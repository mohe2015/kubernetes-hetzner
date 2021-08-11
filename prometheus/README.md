```bash
https://prometheus.io/docs/introduction/overview/

https://github.com/prometheus-operator/kube-prometheus

git clone https://github.com/prometheus-operator/kube-prometheus repos/kube-prometheus
cd repos/kube-prometheus

# TODO FIXME some of the prometheus rules seem to be not working for my cluster setup (although I used kubeadm)

# Create the namespace and CRDs, and then wait for them to be available before creating the remaining resources
kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f manifests/

kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090

http://localhost:9090

kubectl --namespace monitoring port-forward svc/grafana 3000

http://localhost:3000

kubectl --namespace monitoring port-forward svc/alertmanager-main 9093

http://localhost:9093


# teardown

kubectl delete --ignore-not-found=true -f manifests/ -f manifests/setup
kubectl delete namespace monitoring


-------------------- old below

https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack

kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
kubectl get pods -n monitoring

TODO https://github.com/prometheus-operator/kube-prometheus#exposing-prometheusalermanagergrafana-via-ingress


helm uninstall kube-prometheus --namespace monitoring
kubectl delete namespace monitoring
```