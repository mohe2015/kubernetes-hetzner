```bash

# https://goharbor.io/docs/2.7.0/install-config/harbor-ha-helm/
# https://goharbor.io/docs/2.7.0/install-config/configure-https/

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

docker login https://harbor.selfmade4u.de/

docker pull debian
docker tag debian:latest harbor.selfmade4u.de/library/debian
docker push harbor.selfmade4u.de/library/debian


docker build -t not-grocy-server .
docker tag not-grocy-server:latest harbor.selfmade4u.de/library/not-grocy-server
docker push harbor.selfmade4u.de/library/not-grocy-server

https://github.com/aquasecurity/trivy/issues/67
https://github.com/aquasecurity/trivy/issues/160

trivy --clear-cache

helm --namespace harbor uninstall harbor
kubectl delete namespace harbor



```