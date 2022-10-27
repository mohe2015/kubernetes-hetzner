https://k3s.io/

hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --name node-1 --datacenter nbg1-dc3

ssh-keygen -R $(hcloud server ip node-1)

hcloud server ssh node-1
sudo apt update && sudo apt upgrade -y
sudo apt install -y apparmor-utils

sudo nano /etc/ssh/sshd_config
Port 2222

sudo systemctl restart sshd
sudo reboot

hcloud server ssh -p 2222 node-1

# https://docs.k3s.io/installation/network-options#dual-stack-installation
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip 23.88.104.23,2a01:4f8:1c1e:4f60::1 --cluster-cidr 10.42.0.0/16,2001:cafe:42:0::/56 --service-cidr 10.43.0.0/16,2001:cafe:42:1::/112" sh -s -




# Check for Ready node, takes ~30 seconds 
k3s kubectl get node 

https://docs.k3s.io/cluster-access


rm -Rf ~/.kube/
mkdir -p ~/.kube/
scp -P 2222 root@$(hcloud server ip node-1):/etc/rancher/k3s/k3s.yaml ~/.kube/config

nano ~/.kube/config 
# set k3s.selfmade4u.de


