https://k3s.io/

# has no "official" swap support

hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --name node-1 --datacenter nbg1-dc3

ssh-keygen -R $(hcloud server ip node-1)

hcloud server ssh node-1

dd if=/dev/zero of=/swapfile bs=1M count=8192
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

nano /etc/fstab
/swapfile       none    swap    sw      0       0

sudo nano /etc/ssh/sshd_config
Port 2222

sudo systemctl restart sshd

sudo apt update && sudo apt upgrade -y
sudo apt install -y apparmor-utils

sudo reboot

hcloud server ssh -p 2222 node-1

# https://www.cisecurity.org/benchmark/kubernetes

# https://docs.k3s.io/reference/server-config

# TODO docs say for VXLAN security we need to enable a firewall

# /usr/local/bin/k3s-uninstall.sh

cat > kubelet-configuration.yaml << EOF
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
failSwapOn: false
featureGates:
  NodeSwap: true
memorySwap:
  swapBehavior: UnlimitedSwap
EOF

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --kubelet-arg="config=/root/kubelet-configuration.yaml" --disable traefik --disable-helm-controller --node-ip 23.88.104.23,2a01:4f8:1c1e:4f60::1 --cluster-cidr 10.42.0.0/16,2001:cafe:42:0::/56 --service-cidr 10.43.0.0/16,2001:cafe:42:1::/112" sh -s -

exit


rm -Rf ~/.kube/
mkdir -p ~/.kube/
scp -P 2222 root@$(hcloud server ip node-1):/etc/rancher/k3s/k3s.yaml ~/.kube/config

nano ~/.kube/config 
# set k3s.selfmade4u.de


# will not get Ready because cni not installed yet 
kubectl get node
kubectl get all --all-namespaces

https://docs.k3s.io/cluster-access
