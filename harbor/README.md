

helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar
cd harbor
kubectl create namespace harbor
helm --namespace harbor install harbor .
\# wait
harbor ingress -> resource information
/etc/hosts from core.harbor.domain to that ip

username admin password Harbor12345

https://goharbor.io/docs/2.3.0/administration/configure-authentication/db-auth/

https://goharbor.io/docs/2.3.0/working-with-projects/create-projects/

sudo mkdir -p /etc/docker/certs.d/core.harbor.domain/
sudo cp ~/Downloads/core-harbor-domain-chain.pem /etc/docker/certs.d/core.harbor.domain/ca.crt

docker login https://core.harbor.domain/


docker build -t not-grocy-server .
docker tag not-grocy-server:latest core.harbor.domain/library/not-grocy-server
docker push core.harbor.domain/library/not-grocy-server

https://github.com/aquasecurity/trivy/issues/67
https://github.com/aquasecurity/trivy/issues/160

trivy --clear-cache



helm --namespace harbor uninstall harbor
kubectl delete namespace harbor

