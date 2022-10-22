# https://kubernetes.io/docs/reference/setup-tools/kubeadm/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

https://github.com/hetznercloud/csi-driver
https://github.com/hetznercloud/hcloud-cloud-controller-manager

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

# if you want to run more than a super-minimal amount of services (e.g. you want to run prometheus) then you need at least one node with 8GB e.g. cx31. Also CPU is really high so maybe better CPX31

# WARNING: THIS IS EXPENSIVE

hcloud server create --type cx31 --image debian-11 --ssh-key Moritz.Hedtke@t-online.de --user-data-from-file kubeadm/cloud-init.yaml --name node-1 --datacenter nbg1-dc3
#hcloud server create --type cx31 --image debian-11 --ssh-key moritz@nixos --user-data-from-file kubeadm/cloud-init.yaml --name node-2 --datacenter hel1-dc2
#hcloud server create --type cx31 --image debian-11 --ssh-key moritz@nixos --user-data-from-file kubeadm/cloud-init.yaml --name node-3 --datacenter fsn1-dc14

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

# https://docs.cilium.io/en/stable/gettingstarted/kubeproxy-free/#kubeproxy-free
hcloud server ssh node-1

./helm/README.md

kubeadm init --skip-phases=addon/kube-proxy --config /root/kubeadm-config.yaml
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl get nodes -o wide
kubectl get pods --all-namespaces -w

kubectl taint nodes node-1 node-role.kubernetes.io/control-plane:NoSchedule-


mkdir -p ~/.kube/
scp root@$(hcloud server ip node-1):/etc/kubernetes/admin.conf ~/.kube/config

# https://kubernetes.io/docs/concepts/cluster-administration/addons/#networking-and-network-policy

# try cilium because it's an incubated project
./cilium/README.md

tail -f /var/log/*

# INSTALL CNI HERE - currently calico recommended
#./calico/README.sh

https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/


kubectl get pods --all-namespaces -w

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
# TODO FIXME something is buggy - why is this needed (the config doesnt seem to apply when joining. maybe use a join yaml config?)
kubectl taint nodes node-2 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-3 node-role.kubernetes.io/master:NoSchedule-

hcloud server enable-protection node-1 delete rebuild
hcloud server enable-protection node-2 delete rebuild
hcloud server enable-protection node-3 delete rebuild

hcloud load-balancer enable-protection load-balancer delete

kubectl get nodes

kubectl get pods --all-namespaces


# test
https://github.com/vmware-tanzu/sonobuoy


# https://github.com/kubernetes-sigs/metrics-server

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl edit deploy -n kube-system metrics-server
# TODO FIXME
# spec.template.spec.containers.args
# - --kubelet-insecure-tls

kubectl -n kube-system logs metrics-server-6dfddc5fb8-mjgpv

kubectl top node



# TODO REALLY IMPORTANT https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/
# https://github.com/kubernetes/community/blob/master/contributors/design-proposals/node/node-allocatable.md#recommended-cgroups-setup

# https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/

# sudo systemctl status system.slice # 994.2M (TODO later move containerd, kubelet which should not be there to other control group)

# sudo systemctl status kubepods.slice # 6.1G limit 7.6

# https://kubernetes.io/docs/tasks/administer-cluster/reconfigure-kubelet/

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


kubectl get nodes







# https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/


# https://kubernetes.io/docs/concepts/containers/runtime-class/#hahahugoshortcode-s3-hbhb


# ----------------- old notes -------------------------

# TODO https://www.hetzner.com/dns-console
# https://dns.hetzner.com/api-docs

# https://github.com/kubernetes/kubeadm/blob/master/docs/ha-considerations.md#keepalived-and-haproxy

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# installing kubeadm, kubelet, kubectl

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#stacked-control-plane-and-etcd-nodes

# https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta3/
# https://pkg.go.dev/k8s.io/kubelet/config/v1beta1?utm_source=godoc#KubeletConfiguration

# on failure:
# kubeadm reset
# iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
# rm -R /etc/cni/net.d

# if already joined cluster:
# remove node using kubectl delete node to try again
# also remove from etcd (if automatic removal failed):
# https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/
# kubectl get pods --namespace kube-system -o wide | grep etcd
# kubectl exec etcd-kubernetes-node-1 -n kube-system -- etcdctl --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt  --endpoints=23.88.58.221:2379,23.88.39.133:2379 member list
# kubectl exec etcd-kubernetes-node-1 -n kube-system -- etcdctl --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt  --endpoints=23.88.58.221:2379,23.88.39.133:2379 member remove e5c87eae083faedd

# kubectl logs -n kube-system kube-flannel-ds-6z5cf


# maintenance
# kubectl drain node-1 --ignore-daemonsets --delete-emptydir-data
# do maintenance
# kubectl uncordon node-1
