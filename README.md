# Vetautet Booking Application

A high-performance ticket booking system built with Java 21, Spring Boot 3, and Domain-Driven Design (DDD).

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                    REST API (:1122)                  │
│                  xxxx-controller                     │
├─────────────────────────────────────────────────────┤
│                 xxxx-application                     │
│              (Use Cases / Services)                  │
├──────────────────────┬──────────────────────────────┤
│    xxxx-domain       │     xxxx-infrastructure      │
│  (Entities, Events)  │  (MySQL, Redis, Kafka, ELK)  │
└──────────────────────┴──────────────────────────────┘
```

**Stack:**
- Java 21 / Spring Boot 3.3.5
- MySQL 8 — primary database
- Redis — caching
- Kafka — async messaging
- Elasticsearch + Logstash + Kibana (ELK) — centralized logging
- Prometheus + Grafana — metrics & monitoring
- Resilience4j — circuit breaker, rate limiter
- Kubernetes + ArgoCD — deployment & GitOps

**Non-functional targets:**
- ~100k TPS throughput
- <3ms latency
- Zero-downtime deploys (rolling update + HPA)

---

## Prerequisites

- Java 21
- Maven 3.8+
- Docker Desktop (with Kubernetes enabled)
- kubectl
- ArgoCD CLI (optional)

---

## Local Development (Docker Compose)

Start all infrastructure (MySQL, Redis, Kafka, ELK, Prometheus, Grafana):

```bash
cd environment
docker compose -f docker-compose-dev.yml up -d
docker compose -f docker-compose-broker-kafka.yml up -d
```

Run the application:

```bash
./mvnw spring-boot:run -pl xxxx-start
```

App runs on: **http://localhost:1122**

**Local service ports:**

| Service       | URL                        | Credentials     |
|---------------|----------------------------|-----------------|
| App           | http://localhost:1122      | -               |
| MySQL         | localhost:3316             | root / root1234 |
| Redis         | localhost:6319             | -               |
| Kibana        | http://localhost:5601      | -               |
| Prometheus    | http://localhost:9090      | -               |
| Grafana       | http://localhost:3000      | admin / admin   |

---

## Kubernetes Deployment

### Quick deploy (build + apply all)

```bash
cd k8s
chmod +x deploy.sh
./deploy.sh
```

### Manual deploy

```bash
# Build Docker image
docker build -t vetautet-app:latest .

# Apply all manifests
kubectl apply -k k8s/
```

**Access points after deploy:**

| Service       | URL                         | Credentials     |
|---------------|-----------------------------|-----------------|
| App           | http://localhost:31122      | -               |
| Grafana       | http://localhost:30030      | admin / admin   |
| Prometheus    | http://localhost:30090      | -               |
| Kafka UI      | http://localhost:30080      | -               |

### Check pod status

```bash
kubectl get pods -n vetautet
kubectl get pods -n vetautet | grep -v Running   # non-running pods
```

### View logs

```bash
kubectl logs -n vetautet -l app=vetautet-app -f
```

---

## ArgoCD (GitOps)

ArgoCD watches the `k8s/` directory and auto-syncs on every push to `main`.

```bash
# Port-forward ArgoCD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get admin password (Linux/Mac)
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d

# Get admin password (Windows PowerShell)
kubectl get secret argocd-initial-admin-secret -n argocd `
  -o jsonpath="{.data.password}" | ForEach-Object {
    [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_))
  }
```

Open: **https://localhost:8080** — login with `admin` / password above.

---

## Canary Deployment

```bash
# Build canary image
docker build -t vetautet-app:canary .

# Deploy canary (1 pod = ~33% traffic alongside 2 stable pods)
kubectl apply -f k8s/app/deployment-canary.yaml

# Monitor canary logs
kubectl logs -n vetautet -l version=canary -f

# Promote canary to stable
kubectl set image deployment/vetautet-app vetautet-app=vetautet-app:canary -n vetautet
kubectl delete -f k8s/app/deployment-canary.yaml

# Rollback canary
kubectl delete -f k8s/app/deployment-canary.yaml
```

---

## Build

```bash
# Full build
./mvnw clean package -DskipTests

# Build Docker image
docker build -t vetautet-app:latest .
```

---

## Project Structure

```
├── xxxx-domain/          # Entities, Value Objects, Domain Events
├── xxxx-application/     # Use Cases, Application Services
├── xxxx-controller/      # REST Controllers
├── xxxx-infrastructure/  # DB, Redis, Kafka, external adapters
├── xxxx-start/           # Boot entry point & configuration
├── k8s/                  # Kubernetes manifests (Kustomize)
│   ├── app/              # App deployment, HPA, canary
│   ├── infrastructure/   # MySQL, Redis, ELK
│   ├── kafka/            # Kafka
│   ├── monitoring/       # Prometheus exporters
│   ├── argocd/           # ArgoCD application & project
│   └── deploy.sh         # One-command deploy script
├── environment/          # Local Docker Compose configs
│   ├── elk/              # Logstash pipeline & config
│   └── prometheus/       # Prometheus scrape config
└── Dockerfile
```