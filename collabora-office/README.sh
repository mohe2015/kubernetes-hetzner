git clone --depth 1 git@github.com:CollaboraOnline/online.git

# https://github.com/CollaboraOnline/online/tree/master/kubernetes/helm

helm upgrade --install --create-namespace --namespace collabora collabora-online ./online/kubernetes/helm/collabora-online/ -f values.yaml

kubectl config set-context --current --namespace=collabora