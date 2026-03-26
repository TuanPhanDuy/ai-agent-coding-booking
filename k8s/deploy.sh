#!/bin/bash
set -e

echo "=== Building app Docker image ==="
cd "$(dirname "$0")/.."
docker build -t vetautet-app:latest .

echo ""
echo "=== Applying Kubernetes manifests ==="
cd k8s

echo "[1/6] Namespace"
kubectl apply -f namespace.yaml

echo "[2/6] ConfigMaps"
kubectl apply -f configmaps/

echo "[3/6] Infrastructure (MySQL, Redis, Prometheus, Grafana)"
kubectl apply -f infrastructure/

echo "[4/6] Kafka"
kubectl apply -f kafka/

echo "[5/6] Monitoring exporters"
kubectl apply -f monitoring/

echo "[6/6] Application + HPA"
kubectl apply -f app/

echo ""
echo "=== Waiting for pods to be ready ==="
kubectl rollout status deployment/grafana       -n vetautet --timeout=120s
kubectl rollout status deployment/prometheus    -n vetautet --timeout=120s
kubectl rollout status statefulset/mysql        -n vetautet --timeout=120s
kubectl rollout status statefulset/redis        -n vetautet --timeout=120s
kubectl rollout status statefulset/kafka        -n vetautet --timeout=180s
kubectl rollout status deployment/vetautet-app  -n vetautet --timeout=180s

echo ""
echo "=== All services ready ==="
kubectl get pods -n vetautet
echo ""
echo "Access points:"
echo "  App:        http://localhost:31122"
echo "  Grafana:    http://localhost:30030  (admin/admin)"
echo "  Prometheus: http://localhost:30090"
echo "  Kafka UI:   http://localhost:30080"
