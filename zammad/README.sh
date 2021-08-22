
# https://docs.zammad.org/en/latest/install/kubernetes.html

# THIS APPLICATION IS SUPER SLOW

# we now repeatedly experience node crashes (likely because of OOM)
# is it maybe possible to set the memory limit of the node

# https://github.com/zammad/zammad-helm

helm repo add zammad https://zammad.github.io/zammad-helm
helm upgrade --install zammad zammad/zammad --namespace=zammad --values zammad/values.yaml --create-namespace

# kubectl get pods -n zammad -w

kubectl --namespace zammad port-forward svc/zammad 8080

# kubectl delete namespace zammad