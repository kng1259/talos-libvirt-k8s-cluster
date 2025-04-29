kubectl apply -f namespace.yaml
helm install postgresql bitnami/mysql -f values.yaml -n database
