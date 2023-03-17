https://fluentbit.io/

kubectl create namespace fluentd
kubectl config set-context --current --namespace=fluentd

https://docs.fluentd.org/how-to-guides/free-alternative-to-splunk-by-fluentd

helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm repo update

helm upgrade --install --namespace fluentd -f fluentbit/opensearch-values.yaml opensearch opensearch/opensearch

helm upgrade --install --namespace fluentd -f fluentbit/opensearch-values.yaml opensearch-dashboards opensearch/opensearch-dashboards

kubectl apply -f fluentbit/gateway.yaml

# username: admin
# password: admin
# RESET PASSWORD

helm repo add fluent https://fluent.github.io/helm-charts

helm upgrade --install --namespace fluentd fluent-bit fluent/fluent-bit -f ./fluentbit/fluent-bit-values.yaml

kubectl -n fluentd logs -f daemonset.apps/fluent-bit

kubectl -n fluentd logs -f service/opensearch-cluster-master

Index pattern: logstash-*
Timestamp field: @timestamp

