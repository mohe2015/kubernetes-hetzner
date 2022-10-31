
#helm repo add metallb https://metallb.github.io/metallb
#helm install metallb metallb/metallb --create-namespace --namespace metallb-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

https://kube-vip.io/docs/about/architecture/

# wait until deployed
kubectl get all --namespace metallb-system

# create floating ip and assign to server
hcloud server ssh node-1
nano /etc/network/interfaces.d/60-floating-ip.cfg
auto eth0:1
iface eth0:1 inet static
  address 116.203.11.86
  netmask 32

systemctl restart networking.service


#     metallb.universe.tf/allow-shared-ip: "floating-ip"




# https://community.hetzner.com/tutorials/install-kubernetes-cluster

# https://github.com/metallb/metallb/issues/462
cat <<EOF |kubectl apply -f-
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
   - 116.203.11.86/32 # floating ip
#  - 23.88.104.23/32
#  - 2a01:4f8:1c1e:4f60::/64
EOF

kubectl get all --namespace metallb-system

kubectl --namespace metallb-system logs deployment.apps/controller

kubectl get svc # shows an ip

# metallb.universe.tf/allow-shared-ip

# curl http://test.selfmade4u.de/

# sudo ip addr add 116.203.11.86 dev eth0

curl http://116.203.11.86:80

kubectl get all --all-namespaces

kubectl describe pods -n default

kubectl get configmaps -n metallb-system config -o yaml