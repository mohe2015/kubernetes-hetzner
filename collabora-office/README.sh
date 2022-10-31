git clone --depth 1 git@github.com:CollaboraOnline/online.git

# https://github.com/CollaboraOnline/online/tree/master/kubernetes/helm

helm upgrade --install --create-namespace --namespace collabora collabora-online ./collabora-office/online/kubernetes/helm/collabora-online/ -f collabora-office/values.yaml

kubectl config set-context --current --namespace=collabora