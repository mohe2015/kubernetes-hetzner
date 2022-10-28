
# https://github.com/kubernetes/dashboard

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm upgrade kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --atomic --cleanup-on-fail --create-namespace --install --reset-values --values kubernetes-dashboard/values.yaml --namespace kubernetes-dashboard

kubectl -n kubernetes-dashboard create token kubernetes-dashboard