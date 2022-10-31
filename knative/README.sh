# https://knative.dev/docs/client/install-kn/

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

kubectl -n knative-serving get -o yaml gateway knative-ingress-gateway

# install func by building from source

cd knative

~/Documents/func/func create --language rust --template http myfunc

cd myfunc

# https://hub.docker.com/repository/docker/devmohe/knative
# docker.io/devmohe

~/Documents/func/func build

~/Documents/func/func deploy

http://myfunc.default.knative.selfmade4u.de/


~/Documents/func/func delete myfunc
