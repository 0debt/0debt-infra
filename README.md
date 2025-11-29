# 0debt Infrastructure Repository

Welcome to **0debt-infra** — the infrastructure and documentation repository for the **0debt** project.  
This repository centralizes **Kubernetes deployment manifests**, **legal/contractual documents**, and **architecture diagrams** so that the entire system can be easily deployed, analyzed, and evaluated.

---

## 🎯 Purpose

This repository is **not** a codebase for any specific microservice.

Instead, it serves as a **single point of reference** to:
1. Deploy all the **0debt microservices** in a local Kubernetes cluster (e.g. Minikube).  
2. Store formal documents such as the **Customer Agreement, Pricing, Privacy Policy, and SLA**.  
3. Provide **visual and technical documentation** of the system's architecture and communication flows.

This structure simplifies evaluation and transparency for instructors, reviewers, and external collaborators.

---

## 🏗️ Repository Structure
```text
e0debt-infra/
│
├── k8s/                     → Kubernetes manifests for local deployment
│
├── docs/                    → Documentation and academic material
│   ├── agreements/          → Service agreements and legal documents
│   │
│   └── diagrams/            → Visual documentation (Mermaid and image exports)
│
└── README.md
```
---

## ⚙️ Deployment Instructions (Local Evaluation)

### Requirements

Before starting, ensure you have installed:

- Docker
- kubectl
- Minikube

You must also have internet access to pull container images from GitHub Container Registry (ghcr.io).

### Step 1 — Start Minikube

```bash
minikube start
```

### Step 2 — Apply All Manifests

```bash
kubectl apply -f k8s/
```

This will deploy the full 0debt stack: users, groups, expenses, notifications, analytics.

---

## 📄 Documents Included

You can find the project‑level contractual and academic documents under `docs/agreements/`:

- **customer-agreement.md** → Terms of use, pricing tiers, SLA references.
- **pricing.md** → Feature and plan comparison table for Free / Pro / Enterprise.
- **privacy-policy.md** → Basic data handling and storage principles.
- **sla.md** → Service‑level objectives, uptime targets, and compensations.

These documents are structured according to ITIL and Google SRE best practices and form part of the academic evaluation.

---

## 🧩 Architecture & Diagrams

All architecture and communication diagrams are kept in `docs/diagrams/` as Markdown files (`.md`) for GitHub preview.

- **Architecture Overview** (`architecture.md`)

---

## 🧑💻 Updating and Maintaining

When any microservice is updated or a new version is released:

1. Open the corresponding `k8s/*.yaml` manifest.
2. Update the `image:` tag to the latest build (for example: `ghcr.io/0debt/analytics-service:v0.4.2`).
3. Commit and push with a clear message such as:

   ```bash
   git commit -m "chore(k8s): update analytics-service to v0.4.2"
   ```

4. The instructor or evaluator can redeploy the updated stack using the same `kubectl apply` command.

---

## 📚 Related Repositories

- [users-service](https://github.com/0debt/users-service)
- [groups-service](https://github.com/0debt/groups-service)
- [expenses-service](https://github.com/0debt/expenses-service)
- [notifications-service](https://github.com/0debt/notifications-service)
- [analytics-service](https://github.com/0debt/analytics-service)
- [frontend](https://github.com/0debt/frontend)
- [api-gateway](https://github.com/0debt/api-gateway)

---

## 🪪 License

Released under the Apache License 2.0.

© 2025 – The 0debt Team, University of Seville
