# https://knative.dev/docs/client/install-kn/

# SEE BELOW FOR KOURIER INSTRUCTIONS

# TODO https://knative.dev/docs/serving/using-auto-tls/ with cert-manager that uses a static secret

# https://knative.dev/docs/install/yaml-install/

# don't use operator as it does random reconciliation

# TODO FIXME remove resouce limits

#   Requests/sec: 1623.7856
#   Requests/sec: 1689.7320
# -c 200   Requests/sec: 1811.4659

# -c 50   Requests/sec: 1840.5495
# -c 100  Requests/sec: 2245.5058
# -c 200  Requests/sec: 2429.4241
# -c 500  Requests/sec: 2686.5199
# -c 1000 Requests/sec: 2349.4153
# -c 2000 Requests/sec: 2311.7490

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-crds.yaml

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-core.yaml

kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.8.0/kourier.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

kubectl --namespace kourier-system get service kourier

kubectl get pods -n knative-serving

# Replace knative.example.com with your domain suffix
kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"knative.selfmade4u.de":""}}'

kubectl -n knative-serving create secret tls selfmade4u.de-wildcard-certificate --dry-run=client -o yaml --save-config --cert=.lego/certificates/selfmade4u.de.crt --key=.lego/certificates/selfmade4u.de.key | kubectl apply -f -

kubectl -n knative-serving edit deployment.apps/net-kourier-controller
CERTS_SECRET_NAMESPACE: knative-serving
CERTS_SECRET_NAME: selfmade4u.de-wildcard-certificate

# https://knative.dev/docs/serving/load-balancing/target-burst-capacity/
kubectl -n knative-serving get -o yaml configmap config-autoscaler | grep target-burst

kubectl apply -f ./knative/knative-redirect-https.yaml

https://github.com/knative-sandbox/net-kourier

kubectl config set-context --current --namespace=default

cd knative

~/Documents/func/func create --language rust --template http myfunc
~/Documents/func/func create --language go --template http hello

cd hello

# https://hub.docker.com/repository/docker/devmohe/knative
# docker.io/devmohe

~/Documents/func/func build

~/Documents/func/func deploy --verbose

kn revisions list

#kn service update hello \
#--traffic hello-00002=50 \
#--traffic @latest=50

# https://knative.dev/docs/serving/configuration/rolling-out-latest-revision-configmap/

https://hello.default.knative.selfmade4u.de


~/Documents/func/func delete myfunc

# has errors
kubectl -n knative-serving logs replicaset.apps/autoscaler-d97cdddf4 -f

hey -z 30s -c 50 "https://hello.default.knative.selfmade4u.de/"

# knative activator high cpu usage
# knative queue high cpu usage
# istio envoy proxy high cpu usage

# -c 50  Requests/sec: 974.5990
# -c 100 Requests/sec: 905.6401

# TRY KOURIER THIS IS THE BEST ONE




# TRY CONTOUR

# use autotls

# http 100   Requests/sec: 1401.8302
# http 200   Requests/sec: 1390.6097
# http 500   Requests/sec: 881.0308

kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-v1.8.0/contour.yaml

kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-v1.8.0/net-contour.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"contour.ingress.networking.knative.dev"}}'

kubectl --namespace contour-external get service envoy

kubectl get pods -n knative-serving

# Replace knative.example.com with your domain suffix
kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"knative.selfmade4u.de":""}}'

kubectl -n contour-external create secret tls selfmade4u.de-wildcard-certificate --dry-run=client -o yaml --save-config --cert=.lego/certificates/selfmade4u.de.crt --key=.lego/certificates/selfmade4u.de.key | kubectl apply -f -

# looks like the config gets automatically reverted
apiVersion: projectcontour.io/v1
kind: HTTPProxy
metadata:
  name: tls-example
  namespace: default
spec:
  virtualhost:
    tls:
      secretName: selfmade4u.de-wildcard-certificate



# istio


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
