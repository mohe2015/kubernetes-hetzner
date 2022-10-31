# https://knative.dev/docs/client/install-kn/

docker run --rm -v "$HOME/.kube/config:/root/.kube/config" gcr.io/knative-releases/knative.dev/client/cmd/kn:latest service list

# https://knative.dev/docs/install/yaml-install/

# TODO FIXME remove resouce limits

#kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-crds.yaml

#kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-core.yaml

kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.8.0/operator.yaml

kubectl config set-context --current --namespace=default

kubectl get deployment knative-operator

# ADD DNS record for *.knative.selfmade4u.de

kubectl logs -f deploy/knative-operator

kubectl apply -f knative/knative-serving.yaml

kubectl get svc istio-ingressgateway -n istio-system

kubectl get deployment -n knative-serving

kubectl get KnativeServing knative-serving -n knative-serving

kubectl apply -f knative/knative-eventing.yaml

kubectl get deployment -n knative-eventing

kubectl get KnativeEventing knative-eventing -n knative-eventing

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


kubectl config set-context --current --namespace=default

istioctl proxy-config route service/knative-local-gateway.istio-system

istioctl x describe service knative-local-gateway.istio-system