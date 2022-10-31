# recommended for knative

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

kubectl create namespace istio-system
kubectl config set-context --current --namespace=istio-system

helm upgrade --install istio-base istio/base -n istio-system
helm upgrade --install istiod istio/istiod -f istio/istiod-values.yaml -n istio-system --wait

kubectl label namespace istio-system istio-injection=enabled

#helm template istio-ingress istio/gateway -f ./istio/ingress-values.yaml --namespace istio-ingress --post-renderer ./istio/kustomize.sh

# https://istio.io/latest/docs/setup/additional-setup/gateway/

helm upgrade --install istio-ingressgateway istio/gateway -f ./istio/ingress-values.yaml --namespace istio-system --wait # --post-renderer ./istio/kustomize.sh

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.15/samples/httpbin/httpbin.yaml

kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "httpbin.selfmade4u.de"
EOF

kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "httpbin.selfmade4u.de"
  gateways:
  - httpbin-gateway
  http:
  - match:
    - uri:
        prefix: /status
    - uri:
        prefix: /delay
    route:
    - destination:
        port:
          number: 8000
        host: httpbin
EOF
