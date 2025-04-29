kubectl apply -f namespace.yaml
helm install prometheus prometheus-community/prometheus -f values.yaml -n monitoring