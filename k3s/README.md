https://k3s.io/

hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --name node-1 --datacenter nbg1-dc3

ssh-keygen -R $(hcloud server ip node-1)

hcloud server ssh node-1


curl -sfL https://get.k3s.io | sh - 
# Check for Ready node, takes ~30 seconds 
k3s kubectl get node 
