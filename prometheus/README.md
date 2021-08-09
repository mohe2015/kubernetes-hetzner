https://prometheus.io/docs/introduction/overview/

https://github.com/prometheus-operator/kube-prometheus

https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack

kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace monitoring

kubectl get pods -n monitoring

TODO https://github.com/prometheus-operator/kube-prometheus#exposing-prometheusalermanagergrafana-via-ingress

kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090

http://localhost:9090

kubectl --namespace monitoring port-forward svc/grafana 3000

http://localhost:3000

kubectl --namespace monitoring port-forward svc/alertmanager-main 9093

http://localhost:9093