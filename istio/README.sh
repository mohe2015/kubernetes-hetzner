# recommended for knative

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

kubectl create namespace istio-system
kubectl config set-context --current --namespace=istio-system

helm upgrade --install istio-base istio/base -n istio-system
helm upgrade --install istiod istio/istiod -f istio/istiod-values.yaml -n istio-system --wait

kubectl create namespace istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled
kubectl config set-context --current --namespace=istio-ingress

helm template istio-ingress istio/gateway -f ./istio/ingress-values.yaml --namespace istio-ingress --post-renderer ./istio/kustomize.sh
helm upgrade --install istio-ingress istio/gateway -f ./istio/ingress-values.yaml --namespace istio-ingress --wait --post-renderer ./istio/kustomize.sh


kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.15/samples/httpbin/httpbin.yaml

kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: istio
  name: ingress
spec:
  rules:
  - host: httpbin.selfmade4u.de
    http:
      paths:
      - path: /status/*
        pathType: Prefix
        backend:
          service:
            name: httpbin
            port:
              number: 8000
EOF
