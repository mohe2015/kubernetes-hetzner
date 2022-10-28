# https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/

helm repo add cilium https://helm.cilium.io/

# helm show values cilium/cilium

# helm pull cilium/cilium --untar --version 1.13.0-rc1


helm upgrade cilium cilium/cilium --create-namespace --install --reset-values --values cilium/values.yaml --version 1.12.3 --namespace kube-system

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

https://github.com/cilium/cilium/pull/21386

https://github.com/cilium/cilium/pull/21749

https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
https://kubernetes.io/docs/concepts/services-networking/ingress/

https://docs.cilium.io/en/stable/gettingstarted/servicemesh/l7-traffic-management/
https://docs.cilium.io/en/stable/gettingstarted/servicemesh/ingress/
https://docs.cilium.io/en/stable/gettingstarted/servicemesh/http/



TEST https://docs.cilium.io/en/stable/gettingstarted/servicemesh/http/

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/platform/kube/bookinfo.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/1.12.3/examples/kubernetes/servicemesh/basic-ingress.yaml

kubectl get --all-namespaces svc

kubectl get --all-namespaces ingress

kubectl get ingress basic-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'