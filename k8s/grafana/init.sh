kubectl apply -f namespace.yaml
helm install grafana grafana/grafana -f values.yaml -n monitoring
kubectl apply -f ingress.yaml -n monitoring