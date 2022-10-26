helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab --namespace gitlab --create-namespace -f gitlab-values.yaml 

https://docs.gitlab.com/charts/

kubectl -n gitlab get all

kubectl get secret <name>-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo
