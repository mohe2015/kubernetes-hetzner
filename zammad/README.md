https://docs.zammad.org/en/latest/install/kubernetes.html


helm repo add zammad https://zammad.github.io/zammad-helm
helm upgrade --install zammad zammad/zammad --namespace=zammad --values values.yaml --create-namespace





kubectl delete namespace zammad