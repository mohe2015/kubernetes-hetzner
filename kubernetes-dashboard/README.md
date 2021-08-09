```bash

# https://github.com/kubernetes/dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.3.1/aio/deploy/recommended.yaml

# https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

kubectl apply -f kubernetes-dashboard/dashboard-adminuser.yaml

kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

kubectl proxy

# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy

kubectl get service -n kubernetes-dashboard

# https://github.com/kubernetes/dashboard/blob/master/docs/user/accessing-dashboard/README.md

# DOESNT WORK YET:
kubectl apply -f kubernetes-dashboard/ingress.yaml

# kubectl describe -n kubernetes-dashboard secrets/kubernetes-dashboard-certs

```