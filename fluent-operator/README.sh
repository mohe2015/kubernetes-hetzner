# DOESN'T WORK PROPERLY

# https://github.com/fluent/fluent-operator

https://github.com/kubesphere-sigs/fluent-operator-walkthrough CONTAINS VALUABLE CONFIGS

kubectl create namespace fluent
kubectl label namespace fluent istio-injection=enabled
kubectl config set-context --current --namespace=fluent







helm repo add elastic https://helm.elastic.co
helm repo update
# install once per cluster
helm upgrade --install elastic-operator elastic/eck-operator -n elastic-system --create-namespace


kubectl logs -n elastic-system sts/elastic-operator


# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
cat <<EOF | kubectl apply -f -
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: elasticsearch-master
spec:
  version: 8.5.0
  http:
    tls:
      selfSignedCertificate:
        disabled: true
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




# this is not possible with basic license
#helm install es-kb-elasticsearch-master elastic/eck-stack -n fluentd --create-namespace

# edit password in values.yaml - warning this is super insecure

kubectl create secret generic es-secret --from-literal=username=elastic --from-literal=password=$(kubectl get secret elasticsearch-master-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')

git clone https://github.com/fluent/fluent-operator
cd fluent-operator

# this can reload config at runtime
helm upgrade fluent-operator --install -n fluent ./fluent-operator/charts/fluent-operator/ -f values.yaml

kubectl apply -f output-es.yaml 




echo https://localhost:5601
echo username elastic
kubectl get secret elasticsearch-master-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
# Kibana -> Stack Management -> Kibana -> Data Views -> Create data view
kubectl port-forward service/elasticsearch-master-kb-http 5601


Index pattern: ks-logstash-log-*
Timestamp field: @timestamp

