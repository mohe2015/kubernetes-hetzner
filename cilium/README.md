# https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/
https://github.com/cilium/cilium

https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/

helm repo add cilium https://helm.cilium.io/

#helm show values cilium/cilium

helm upgrade cilium cilium/cilium --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --values cilium-values.yaml --version 1.12.3 --namespace kube-system

# TODO taint the nodes at install?
kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,HOSTNETWORK:.spec.hostNetwork --no-headers=true | grep '<none>' | awk '{print "-n "$1" "$2}' | xargs -L 1 -r kubectl delete pod


kubectl -n kube-system get pods --watch
kubectl create ns cilium-test
kubectl apply -n cilium-test -f https://raw.githubusercontent.com/cilium/cilium/1.12.3/examples/kubernetes/connectivity-check/connectivity-check.yaml
kubectl get pods -n cilium-test
kubectl delete ns cilium-test


kubectl port-forward -n kube-system deployment/hubble-ui 8081
kubectl port-forward -n kube-system deployment/hubble-relay 50051:4245