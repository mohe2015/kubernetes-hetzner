https://k3s.io/

```
hcloud server create --user-data-from-file k3s/cloud-init.yaml --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --name node-1 --datacenter nbg1-dc3

ssh-keygen -R $(hcloud server ip node-1)
hcloud server ssh node-1 -o StrictHostKeyChecking=accept-new tail -f /var/log/cloud-init-output.log

sysctl -w fs.inotify.max_user_watches=100000
sysctl -w fs.inotify.max_user_instances=100000

rm -Rf ~/.kube/
mkdir -p ~/.kube/
scp root@$(hcloud server ip node-1):/etc/rancher/k3s/k3s.yaml ~/.kube/config

nano ~/.kube/config 
# set k3s.selfmade4u.de


kubectl get node
kubectl get all --all-namespaces

https://docs.k3s.io/cluster-access

```