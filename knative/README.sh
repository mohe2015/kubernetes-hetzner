# https://knative.dev/docs/client/install-kn/

# TODO https://knative.dev/docs/serving/using-auto-tls/ with cert-manager that uses a static secret

docker run --rm -v "$HOME/.kube/config:/root/.kube/config" gcr.io/knative-releases/knative.dev/client/cmd/kn:latest service list

# https://knative.dev/docs/install/yaml-install/

# don't use operator as it does random reconciliation

# TODO FIXME remove resouce limits

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-crds.yaml

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-core.yaml

# ADD DNS record for *.knative.selfmade4u.de

kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.8.0/net-istio.yaml

kubectl get pods -n knative-serving

kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"knative.selfmade4u.de":""}}'

kubectl -n knative-serving get -o yaml gateway knative-ingress-gateway

kubectl patch gateway/knative-ingress-gateway \
  --namespace knative-serving \
  --type merge \
  --patch-file ./knative/knative-serving-tls.yaml

kubectl patch configmap/config-network --namespace knative-serving --patch-file ./knative/knative-redirect-https.yaml

kubectl -n knative-serving get -o yaml gateway knative-ingress-gateway

# install func by building from source

kubectl config set-context --current --namespace=default

cd knative

~/Documents/func/func create --language rust --template http myfunc
~/Documents/func/func create --language go --template http hello

cd myfunc

# https://hub.docker.com/repository/docker/devmohe/knative
# docker.io/devmohe

~/Documents/func/func build

~/Documents/func/func deploy --verbose

http://myfunc.default.knative.selfmade4u.de/


~/Documents/func/func delete myfunc

# has errors
kubectl -n knative-serving logs replicaset.apps/autoscaler-d97cdddf4 -f

hey -z 30s -c 50 "http://hello.default.knative.selfmade4u.de/"

# knative activator high cpu usage
# knative queue high cpu usage
# istio envoy proxy high cpu usage

# -c 50  Requests/sec: 974.5990
# -c 100 Requests/sec: 905.6401

# TRY KOURIER

https://github.com/knative-sandbox/net-kourier