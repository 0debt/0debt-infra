#!/bin/bash

# start-dev.sh
# Script to deploy 0debt infrastructure on Kubernetes and set up port-forwarding.
# Compatible with Windows (Git Bash / WSL) and Linux/macOS.

NAMESPACE="0debt"
TIMEOUT="300s"

echo "🚀 Starting 0debt deployment..."

# Check if Minikube is running
if ! minikube status >/dev/null 2>&1; then
  echo "⚠️  Minikube is not running. Starting Minikube..."
  minikube start --driver=docker
  if [ $? -ne 0 ]; then
    echo "❌ Failed to start Minikube. Please check Docker Desktop status."
    exit 1
  fi
fi

# 1. Apply Kubernetes manifests
echo "📦 Applying manifests..."
kubectl apply -k .
if [ $? -ne 0 ]; then
    echo "❌ Failed to apply manifests. Is kubectl configured correctly?"
    exit 1
fi

# 2. Wait for deployments to be ready
echo "⏳ Waiting for deployments to be ready (Timeout: $TIMEOUT)..."

deployments=(
  "mongo"
  "redis"
  "users-service"
  "groups-service"
  "expenses-service"
  "analytics-service"
  "notifications-service"
  "api-gateway"
  "frontend"
)

for deploy in "${deployments[@]}"; do
  echo "   - Waiting for deployment: $deploy..."
  kubectl wait --namespace "$NAMESPACE" \
    --for=condition=available \
    --timeout="$TIMEOUT" \
    deployment/"$deploy" || {
      echo "❌ Error waiting for $deploy. Fetching logs..."
      kubectl logs -n "$NAMESPACE" -l app="$deploy" --tail=20
      echo "⚠️  Continuing... check the error above."
    }
done

echo "✅ All deployments are ready (or timed out)."

# 3. Port Forwarding
echo "🔌 Setting up Port Forwarding..."

# Helper function to kill background jobs on exit
cleanup() {
  echo ""
  echo "🛑 Stopping port-forwards..."
  kill $(jobs -p) 2>/dev/null
  echo "👋 Done."
}
trap cleanup EXIT

# Forwarding
# Mongo
echo "   - Mongo: localhost:27017 -> 27017"
kubectl port-forward -n "$NAMESPACE" svc/mongo 27017:27017 &

# Redis
echo "   - Redis: localhost:6379 -> 6379"
kubectl port-forward -n "$NAMESPACE" svc/redis 6379:6379 &

# API Gateway
echo "   - API Gateway: localhost:8000 -> 8000"
kubectl port-forward -n "$NAMESPACE" svc/api-gateway 8000:8000 &

# Frontend
echo "   - Frontend: localhost:3000 -> 3000"
kubectl port-forward -n "$NAMESPACE" svc/frontend 3000:3000 &

echo ""
echo "🎉 Environment is ready!"
echo "   Frontend:    http://localhost:3000"
echo "   API Gateway: http://localhost:8000"
echo "   Mongo:       mongodb://localhost:27017"
echo ""
echo "Press Ctrl+C to stop."

# Keep script running
wait
