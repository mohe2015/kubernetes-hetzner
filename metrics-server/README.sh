# https://github.com/kubernetes-sigs/metrics-server

helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

helm upgrade metrics-server metrics-server/metrics-server --atomic --cleanup-on-fail --create-namespace --install --reset-values --values metrics-server/values.yaml
