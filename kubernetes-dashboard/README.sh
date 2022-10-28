
# https://github.com/kubernetes/dashboard

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm upgrade kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --atomic --cleanup-on-fail --create-namespace --install --reset-values --values kubernetes-dashboard/values.yaml --namespace kubernetes-dashboard


https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

kubectl apply -f kubernetes-dashboard/user.yaml

kubectl -n kubernetes-dashboard create token admin-user