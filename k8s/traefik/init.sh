kubectl apply -f namespace.yaml
helm install traefik traefik/traefik -f values.yaml -n traefik