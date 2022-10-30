# recommended for knative

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

kubectl create namespace istio-system

helm upgrade --install istio-base istio/base -n istio-system
helm upgrade --install istiod istio/istiod -f istio/istiod-values.yaml -n istio-system --wait

kubectl create namespace istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled

kubectl config set-context --current --namespace=istio-ingress

helm template istio-ingress istio/gateway -f ./istio/ingress-values.yaml --namespace istio-ingress --post-renderer ./istio/kustomize.sh
helm upgrade --install istio-ingress istio/gateway -f ./istio/ingress-values.yaml --namespace istio-ingress --wait --post-renderer ./istio/kustomize.sh

helm status istiod -n istio-system

helm show values istio/base
helm show values istio/gateway

# https://istio.io/latest/docs/setup/additional-setup/customize-installation-helm/