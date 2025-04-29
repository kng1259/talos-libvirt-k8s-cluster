kubectl apply -f namespace.yaml
helm install postgresql bitnami/postgresql -f values.yaml -n database
