
#helm repo add metallb https://metallb.github.io/metallb
#helm install metallb metallb/metallb --create-namespace --namespace metallb-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

https://kube-vip.io/docs/about/architecture/

cat <<EOF |kubectl apply -f-
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 23.88.104.23/32
#  - 2a01:4f8:1c1e:4f60::/64
EOF

kubectl get all --namespace metallb

kubectl --namespace metallb logs deployment.apps/metallb-controller

kubectl get svc

# metallb.universe.tf/allow-shared-ip

 kubectl get all --all-namespaces

kubectl describe pods -n default

kubectl get configmaps -n metallb-system config -o yaml