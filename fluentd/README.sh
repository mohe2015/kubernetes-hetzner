https://fluentbit.io/

helm repo add fluent https://fluent.github.io/helm-charts

kubectl create namespace fluentd
kubectl label namespace fluentd istio-injection=enabled

kubectl config set-context --current --namespace=fluentd


https://docs.fluentd.org/how-to-guides/free-alternative-to-splunk-by-fluentd

helm repo add elastic https://helm.elastic.co
helm repo update
helm install elastic-operator elastic/eck-operator -n fluentd --create-namespace

# alternatively don't use operator but https://raw.githubusercontent.com/elastic/helm-charts/master/elasticsearch/examples/minikube/values.yaml
# https://phoenixnap.com/kb/elasticsearch-helm-chart

kubectl logs -n fluentd sts/elastic-operator


# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
cat <<EOF | kubectl apply -f -
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: elasticsearch-master
spec:
  version: 8.5.0
  nodeSets:
  - name: default
    count: 1
    config:
      node.store.allow_mmap: false
EOF

kubectl get elasticsearch --watch
kubectl get pods --selector='elasticsearch.k8s.elastic.co/cluster-name=elasticsearch-master'
kubectl logs -f elasticsearch-master-es-default-0
kubectl get service elasticsearch-master-es-http
PASSWORD=$(kubectl get secret elasticsearch-master-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
kubectl port-forward service/elasticsearch-master-es-http 9200
curl -u "elastic:$PASSWORD" -k "https://localhost:9200"


# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-kibana.html
cat <<EOF | kubectl apply -f -
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: elasticsearch-master
spec:
  version: 8.5.0
  count: 1
  elasticsearchRef:
    name: elasticsearch-master
EOF

kubectl get kibana --watch
kubectl get pod --selector='kibana.k8s.elastic.co/name=elasticsearch-master'
kubectl get service quickstelasticsearch-masterart-kb-http
kubectl port-forward service/elasticsearch-master-kb-http 5601
echo https://localhost:5601
echo username elastic
kubectl get secret elasticsearch-master-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo





# this is not possible with basic license
#helm install es-kb-elasticsearch-master elastic/eck-stack -n fluentd --create-namespace


# edit password in values.yaml - warning this is super insecure

helm upgrade --install fluent-bit fluent/fluent-bit -f ./fluentd/fluent-bit-values.yaml --namespace fluentd

export POD_NAME=$(kubectl get pods --namespace fluentd -l "app.kubernetes.io/name=fluent-bit,app.kubernetes.io/instance=fluent-bit" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace fluentd port-forward $POD_NAME 2020:2020
curl http://127.0.0.1:2020

kubectl logs daemonset.apps/fluent-bit

kubectl get secret elasticsearch-master-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'


# Kibana -> Stack Management -> Kibana -> Data Views -> Create data view


Index pattern: logstash-*
Timestamp field: @timestamp