```bash
https://docs.zammad.org/en/latest/install/kubernetes.html


# we now repeatedly experience node crashes (likely because of OOM)
# is it maybe possible to set the memory limit of the node



helm repo add zammad https://zammad.github.io/zammad-helm
helm upgrade --install zammad zammad/zammad --namespace=zammad --values zammad/values.yaml --create-namespace


kubectl get pods -n zammad -w


kubectl delete namespace zammad
```