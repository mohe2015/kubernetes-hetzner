# istio's issue stalebot is such a huge fuckup we shouldn't use this

# recommended for knative

# DISABLE IPV6 DNS RECORDS AS IT STILL DOESNT SUPPORT IPV6

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

kubectl label namespace default istio-injection=enabled

kubectl apply -f istio/ingressclass.yaml

# https://istio.io/latest/docs/reference/config/networking/gateway/

istioctl proxy-status

istioctl proxy-config route httpbin-9dbd644c7-vz8qf.istio-system

istioctl proxy-config route istio-ingressgateway-7b978877cb-dxjns.istio-system

istioctl analyze

# https://istio.io/latest/docs/ops/diagnostic-tools/proxy-cmd/

istioctl proxy-config cluster istio-ingressgateway-7b978877cb-dxjns.istio-system



# https://istio.io/latest/docs/ops/diagnostic-tools/istioctl-describe/

istioctl x describe pod httpbin-9dbd644c7-vz8qf

curl --verbose http://httpbin.selfmade4u.de/status/418 # works as status code is 418


# https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/