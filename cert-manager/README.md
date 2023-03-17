https://cert-manager.io/docs/usage/gateway/

https://cert-manager.io/docs/configuration/acme/dns01/

it doesn't have good support and hetzner doesn't have a good dns api (that is secure)
just do dns challenge manually for now

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm upgrade --install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  -f cert-manager/values.yaml