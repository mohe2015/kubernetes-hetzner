https://k3s.io/

hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --name node-1 --datacenter nbg1-dc3

ssh-keygen -R $(hcloud server ip node-1)

hcloud server ssh node-1
sudo apt update && sudo apt upgrade -y
sudo apt install -y apparmor-utils

curl -sfL https://get.k3s.io | sh - 
# Check for Ready node, takes ~30 seconds 
k3s kubectl get node 

https://docs.k3s.io/cluster-access


rm -Rf ~/.kube/
mkdir -p ~/.kube/
scp root@$(hcloud server ip node-1):/etc/rancher/k3s/k3s.yaml ~/.kube/config

nano ~/.kube/config 
# set k3s.selfmade4u.de



sudo nano /etc/ssh/sshd_config
Port 2222

sudo systemctl restart sshd

hcloud server ssh -p 2222 node-1