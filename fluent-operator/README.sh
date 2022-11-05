# https://github.com/fluent/fluent-operator


kubectl create namespace fluent
kubectl label namespace fluent istio-injection=enabled

git clone https://github.com/fluent/fluent-operator
cd fluent-operator

helm upgrade fluent-operator --install --create-namespace -n fluent ./fluent-operator/charts/fluent-operator/ -f values.yaml

kubectl config set-context --current --namespace=fluent

https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/
https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container

kubectl -n fluent debug -it pod/fluent-bit-45sbp --image=archlinux