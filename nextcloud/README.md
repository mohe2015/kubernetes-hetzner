https://github.com/nextcloud/helm

helm repo add nextcloud https://nextcloud.github.io/helm/
helm repo update

helm install nextcloud nextcloud/nextcloud

helm upgrade --install nextcloud nextcloud/nextcloud -f nextcloud-values.yaml 
