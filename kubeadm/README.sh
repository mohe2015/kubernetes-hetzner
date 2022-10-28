# https://kubernetes.io/docs/reference/setup-tools/kubeadm/

# install hcloud https://github.com/hetznercloud/cli
# hcloud context create kubernetes

# CX31
# 2 VCPU
# 8 GB RAM
# 80 GB DISK LOKAL

#hcloud server delete node-1
#hcloud server delete node-2
#hcloud server delete node-3
#hcloud load-balancer delete load-balancer

# these three can be done in parallel

hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --user-data-from-file kubeadm/cloud-init.yaml --name node-1 --datacenter nbg1-dc3
#hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --user-data-from-file kubeadm/cloud-init.yaml --name node-2 --datacenter hel1-dc2
#hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --user-data-from-file kubeadm/cloud-init.yaml --name node-3 --datacenter fsn1-dc14

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#create-load-balancer-for-kube-apiserver

#hcloud load-balancer create --name load-balancer --type lb11 --location nbg1

echo UPDATE DNS (TODO AUTOMATE) (WARNING IPV6 may change when ipv6 doesnt)
read

#hcloud load-balancer add-target load-balancer --server node-1
#hcloud load-balancer add-target load-balancer --server node-2
#hcloud load-balancer add-target load-balancer --server node-3

#hcloud load-balancer add-service load-balancer --listen-port 6443 --destination-port 6443 --protocol tcp
#hcloud load-balancer update-service load-balancer --listen-port 6443 --destination-port 6443 --protocol tcp --health-check-http-domain kube-apiserver.selfmade4u.de --health-check-http-path "/livez?verbose" --health-check-http-response "livez check passed" --health-check-http-status-codes 200 --health-check-interval 3s --health-check-port 6443 --health-check-protocol http --health-check-retries 0 --health-check-timeout 2s --health-check-http-tls

# wait until all nodes have booted and then rebooted

# TODO find out ssh host key in advance by specifying it in cloud-init config
ssh-keygen -R $(hcloud server ip node-1)
hcloud server ssh node-1 -o StrictHostKeyChecking=accept-new tail -f /var/log/cloud-init-output.log # TODO FIXME automate reboot detection

hcloud server ssh node-1

# install helm on your local device

# https://docs.cilium.io/en/stable/gettingstarted/kubeproxy-free/#kubeproxy-free
kubeadm init --config /root/kubeadm-config.yaml

#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config


# on local machine
exit
rm -Rf ~/.kube/
mkdir -p ~/.kube/
scp root@$(hcloud server ip node-1):/etc/kubernetes/admin.conf ~/.kube/config

kubectl describe node

kubectl get all --all-namespaces

# TODO https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#resilience

# https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/

# TODO run script on server
certificate_key=$(hcloud server ssh node-1 kubeadm certs certificate-key)
hcloud server ssh node-1 kubeadm init phase upload-certs --upload-certs --certificate-key=$certificate_key
control_plane_join_command=$(hcloud server ssh node-1 kubeadm token create --certificate-key $certificate_key --print-join-command)
worker_join_command=$(hcloud server ssh node-1 kubeadm token create --print-join-command)
echo $control_plane_join_command
echo $worker_join_command

ssh-keygen -R $(hcloud server ip node-2)
hcloud server ssh node-2 -o StrictHostKeyChecking=accept-new $control_plane_join_command --ignore-preflight-errors=Swap
hcloud server ssh node-2 mkdir -p /root/.kube/
hcloud server ssh node-2 cp /etc/kubernetes/admin.conf /root/.kube/config

ssh-keygen -R $(hcloud server ip node-3)
hcloud server ssh node-3 -o StrictHostKeyChecking=accept-new $control_plane_join_command --ignore-preflight-errors=Swap
hcloud server ssh node-3 mkdir -p /root/.kube/
hcloud server ssh node-3 cp /etc/kubernetes/admin.conf /root/.kube/config

kubectl taint nodes node-1 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-2 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-3 node-role.kubernetes.io/master:NoSchedule-

hcloud server enable-protection node-1 delete rebuild
hcloud server enable-protection node-2 delete rebuild
hcloud server enable-protection node-3 delete rebuild

hcloud load-balancer enable-protection load-balancer delete

kubectl get nodes

kubectl get pods --all-namespaces




# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
# apt update
# apt-get install -y --allow-change-held-packages kubeadm=1.22.0-00


# for first node
# kubeadm upgrade plan # take note of required manual updates
# kubeadm upgrade apply --config /root/kubeadm-config.yaml v1.22.0

# for other nodes
# sudo kubeadm upgrade node

# apt-get install -y --allow-change-held-packages kubelet=1.22.0-00 kubectl=1.22.0-00
# sudo systemctl daemon-reload
# sudo systemctl restart kubelet


# maintenance
# kubectl drain node-1 --ignore-daemonsets --delete-emptydir-data
# do maintenance
# kubectl uncordon node-1
