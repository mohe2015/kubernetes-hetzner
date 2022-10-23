# https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/

helm repo add cilium https://helm.cilium.io/

# helm show values cilium/cilium

helm upgrade cilium cilium/cilium --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --values values.yaml --version 1.12.3 --namespace kube-system

kubectl -n kube-system get pods --watch
kubectl create ns cilium-test
kubectl apply -n cilium-test -f https://raw.githubusercontent.com/cilium/cilium/1.12.3/examples/kubernetes/connectivity-check/connectivity-check-single-node.yaml
kubectl wait --for=condition=Ready --timeout=1h pods --all -n cilium-test
kubectl get pods -n cilium-test

# kubectl get events -A

kubectl delete ns cilium-test

echo http://localhost:8081/

kubectl port-forward -n kube-system deployment/hubble-ui 8081

# kubectl port-forward -n kube-system deployment/hubble-relay 50051:4245

