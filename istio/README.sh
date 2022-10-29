# recommended for knative

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

kubectl create namespace istio-system

helm upgrade --install istio-base istio/base -n istio-system
helm upgrade --install istiod istio/istiod -f istio/istiod-values.yaml -n istio-system --wait

kubectl create namespace istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled

# TODO FIXME

helm pull --untar istio/gateway

helm upgrade --install istio-ingress istio/gateway -n istio-ingress --wait

helm status istiod -n istio-system

helm show values istio/base
helm show values istio/gateway

# https://istio.io/latest/docs/setup/additional-setup/customize-installation-helm/