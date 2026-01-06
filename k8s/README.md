# Local Deployment - 0debt

## Requirements

1. **Docker Desktop** - https://www.docker.com/products/docker-desktop/
   - Install it and ensure it is running (check the system tray icon).

2. **Minikube and kubectl**

### Windows
```powershell
winget install Kubernetes.minikube
winget install Kubernetes.kubectl
```

### macOS
```bash
brew install minikube kubectl
```

### Linux
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
```

## Deployment (Recommended)

**Ensure Docker Desktop is running before executing.**

The recommended method is using the automated script that applies changes, waits for services to be ready, and configures ports automatically.

### Windows / macOS / Linux (via Bash)
From the **k8s/** folder, run:

```bash
./start-dev.sh
```

> **Note for Windows:** Use **Git Bash** or **WSL** to execute this script.

---

## Manual Deployment (One Command)

If you prefer not to use the script:

### Windows PowerShell
```powershell
minikube start --driver=docker; kubectl apply -k .; Write-Host "Waiting for pods..."; Start-Sleep 90; kubectl port-forward svc/frontend 3000:3000 -n 0debt
```

### macOS / Linux
```bash
minikube start --driver=docker && kubectl apply -k . && echo "Waiting for pods..." && sleep 90 && kubectl port-forward svc/frontend 3000:3000 -n 0debt
```

## External APIs Configuration (Optional)

The application is fully functional for local evaluation without configuring external APIs.

However, if you wish to test specific features such as email sending, avatars, or group covers, you can configure your own keys in the `k8s/01-secrets.yaml` file:

- **Emails (Resend):** Real notifications.
- **Avatars (Supabase):** Profile picture uploads.
- **Covers (Unsplash):** Random images for groups.

For more details, check the `k8s/APIS_EXTERNAS.txt` file.

---

## Verify Status

```bash
kubectl get pods -n 0debt
```

## Cleanup

```bash
kubectl delete namespace 0debt
minikube stop
```

## Troubleshooting

### "Cannot connect to the Docker daemon"
Ensure Docker Desktop is running.

### Pods do not start
```bash
kubectl logs deployment/<service> -n 0debt
kubectl get events -n 0debt
```

### Out of Memory
```bash
minikube stop
minikube start --driver=docker --memory=4096
kubectl apply -k .
```