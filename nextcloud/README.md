https://github.com/nextcloud/helm

helm repo add nextcloud https://nextcloud.github.io/helm/
helm repo update


helm upgrade --create-namespace --namespace nextcloud --install nextcloud nextcloud/nextcloud -f nextcloud-values.yaml 

kubectl config set-context --current --namespace=nextcloud

export APP_HOST=127.0.0.1
export APP_PASSWORD=$(kubectl get secret --namespace gitlab nextcloud -o jsonpath="{.data.nextcloud-password}" | base64 --decode)