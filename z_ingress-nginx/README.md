https://kubernetes.github.io/ingress-nginx/
https://kubernetes.github.io/ingress-nginx/deploy/baremetal/

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace -f ingress-nginx/values.yaml

# because only one hostport is allowed per node we need to manually delete the ingress-nginx-controller


kubectl get pods --namespace=ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s