```bash

# https://helm.sh/docs/intro/quickstart/
# https://goharbor.io/docs/2.3.0/install-config/harbor-ha-helm/
# https://goharbor.io/docs/2.3.0/install-config/configure-https/

helm repo add harbor https://helm.goharbor.io
helm repo update
kubectl create namespace harbor
helm --namespace harbor install harbor harbor/harbor --values values.yaml

helm show values harbor/harbor
helm list
helm status harbor

helm --namespace harbor upgrade harbor harbor/harbor --values values.yaml


\# wait

https://harbor.selfmade4u.de

admin Harbor12345

# change password

https://goharbor.io/docs/2.3.0/administration/configure-authentication/db-auth/

https://goharbor.io/docs/2.3.0/working-with-projects/create-projects/

docker login https://harbor.selfmade4u.de/


docker build -t not-grocy-server .
docker tag not-grocy-server:latest harbor.selfmade4u.de/library/not-grocy-server
docker push harbor.selfmade4u.de/library/not-grocy-server

https://github.com/aquasecurity/trivy/issues/67
https://github.com/aquasecurity/trivy/issues/160

trivy --clear-cache

helm --namespace harbor uninstall harbor
kubectl delete namespace harbor



```