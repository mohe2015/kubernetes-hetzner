```bash

# https://goharbor.io/

helm repo add harbor https://helm.goharbor.io
# TODO FIXME use the method where you just have an override values.yaml
cd repos
helm fetch harbor/harbor --untar
cd harbor
kubectl create namespace harbor
nano values.yaml
helm --namespace harbor install harbor .


#helm --namespace harbor upgrade harbor harbor/harbor --values values.yaml


\# wait

https://harbor.selfmade4u.de

username admin password Harbor12345

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