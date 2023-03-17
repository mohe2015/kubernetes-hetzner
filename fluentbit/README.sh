https://fluentbit.io/

kubectl create namespace fluent-bit
kubectl config set-context --current --namespace=fluent-bit

https://docs.fluentd.org/how-to-guides/free-alternative-to-splunk-by-fluentd

helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm repo update

helm upgrade --install --namespace fluent-bit -f fluentbit/opensearch-values.yaml opensearch opensearch/opensearch

helm upgrade --install --namespace fluent-bit -f fluentbit/opensearch-values.yaml opensearch-dashboards opensearch/opensearch-dashboards

kubectl apply -f fluentbit/gateway.yaml

# username: admin
# password: admin
# RESET PASSWORD

helm repo add fluent https://fluent.github.io/helm-charts

helm upgrade --install --namespace fluent-bit fluent-bit fluent/fluent-bit -f ./fluentbit/fluent-bit-values.yaml

kubectl -n fluent-bit logs -f daemonset.apps/fluent-bit

kubectl -n fluent-bit logs -f service/opensearch-cluster-master

# Stack Management -> Index Patterns
Index pattern: logstash-*
Timestamp field: @timestamp

# Discover

# Anomaly Detection -> Detectors
# logstash-*
# Detector interval 10 minute
# Window Delay 1 minute