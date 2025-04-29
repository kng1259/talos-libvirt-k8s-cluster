kubectl apply -f namespace.yaml
helm install metallb metallb/metallb -f values.yaml -n metallb
kubectl apply -f values.yaml -n metallb