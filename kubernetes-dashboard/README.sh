
# https://github.com/kubernetes/dashboard

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm upgrade kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --values values.yaml --namespace kubernetes-dashboard


kubectl apply -f dashboard-adminuser.yaml

kubectl -n kubernetes-dashboard create token admin-user

export POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
echo https://127.0.0.1:8443/
kubectl -n kubernetes-dashboard port-forward $POD_NAME 8443:8443
