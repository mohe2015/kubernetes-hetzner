https://fluentbit.io/

kubectl create namespace fluentd
kubectl config set-context --current --namespace=fluentd

https://docs.fluentd.org/how-to-guides/free-alternative-to-splunk-by-fluentd

helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm repo update

helm upgrade --install --namespace fluentd -f fluentbit/opensearch-values.yaml opensearch opensearch/opensearch

helm upgrade --install --namespace fluentd -f fluentbit/opensearch-values.yaml opensearch-dashboards opensearch/opensearch-dashboards



helm repo add fluent https://fluent.github.io/helm-charts

helm upgrade --install fluent-bit fluent/fluent-bit -f ./fluentd/fluent-bit-values.yaml --namespace fluentd

kubectl auth can-i list pods --as=system:serviceaccount:fluentd:fluentbit

export POD_NAME=$(kubectl get pods --namespace fluentd -l "app.kubernetes.io/name=fluent-bit,app.kubernetes.io/instance=fluent-bit" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace fluentd port-forward $POD_NAME 2020:2020
curl http://127.0.0.1:2020

kubectl logs daemonset.apps/fluent-bit -f


echo https://localhost:5601
echo username elastic
kubectl get secret elasticsearch-master-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
kubectl port-forward service/elasticsearch-master-kb-http 5601
# Kibana -> Stack Management -> Kibana -> Data Views -> Create data view


Index pattern: logstash-*
Timestamp field: @timestamp

helm uninstall fluent-bit # don't simply delete the namespace

# https://github.com/fluent/helm-charts/blob/main/charts/fluent-bit/templates/clusterrolebinding.yaml
# kubectl get -o yaml ClusterRoleBinding fluent-bit
kubectl auth can-i list pods -A --as=system:serviceaccount:fluentd:fluentbit

kubectl apply -f fluentd/permissions.yaml

kubectl delete pod/fluent-bit-8vwqt # because logs get rotated quickly
kubectl logs daemonset.apps/fluent-bit | grep -B 15 -A 15 upstream

https://github.com/istio/istio/issues/11130 reason why kubernetes connections fail at start