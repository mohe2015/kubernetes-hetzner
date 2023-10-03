```bash

# https://goharbor.io/docs/2.7.0/install-config/harbor-ha-helm/

helm repo add harbor https://helm.goharbor.io
helm repo update
kubectl create namespace harbor

# https://github.com/goharbor/harbor-helm

helm --namespace harbor upgrade --install harbor harbor/harbor --values harbor/values.yaml

kubectl apply -f harbor/gateway.yaml

https://harbor.selfmade4u.de

admin Harbor12345

# change password

https://goharbor.io/docs/2.7.0/administration/configure-authentication/db-auth/

https://goharbor.io/docs/2.7.0/working-with-projects/create-projects/

podman login https://harbor.selfmade4u.de/

podman pull docker.io/library/debian:latest
podman tag docker.io/library/debian:latest harbor.selfmade4u.de/library/debian:latest
podman push harbor.selfmade4u.de/library/debian:latest


```