```bash

# https://kubernetes.io/docs/reference/setup-tools/kubeadm/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

# TODO FIXME is kubernetes + etcd communicating encrypted?

https://github.com/hetznercloud/csi-driver
https://github.com/hetznercloud/hcloud-cloud-controller-manager

# install hcloud https://github.com/hetznercloud/cli
# hcloud context create kubernetes

# create three servers of type cx21 (min 40GB disk, min 4G RAM)
# may be useful to have some 8GB instances as it's still pretty hard to run a few things

hcloud server delete node-1
hcloud server delete node-2
hcloud server delete node-3
hcloud load-balancer delete load-balancer

# these three can be done in parallel

# if you want to run more than a super-minimal amount of services (e.g. you want to run prometheus) then you need at least one node with 8GB e.g. cx31. Also CPU is really high so maybe better CPX31

hcloud server create --type cx21 --image debian-11 --ssh-key moritz@nixos --user-data-from-file kubeadm/cloud-init.yaml --name node-1 --datacenter nbg1-dc3
hcloud server create --type cx21 --image debian-11 --ssh-key moritz@nixos --user-data-from-file kubeadm/cloud-init.yaml --name node-2 --datacenter hel1-dc2
hcloud server create --type cx21 --image debian-11 --ssh-key moritz@nixos --user-data-from-file kubeadm/cloud-init.yaml --name node-3 --datacenter fsn1-dc14

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#create-load-balancer-for-kube-apiserver

hcloud load-balancer create --name load-balancer --type lb11 --location nbg1

# UPDATE DNS (TODO AUTOMATE) (WARNING IPV6 may change when ipv6 doesnt)

hcloud load-balancer add-target load-balancer --server node-1
hcloud load-balancer add-target load-balancer --server node-2
hcloud load-balancer add-target load-balancer --server node-3

hcloud load-balancer add-service load-balancer --listen-port 6443 --destination-port 6443 --protocol tcp
hcloud load-balancer update-service load-balancer --listen-port 6443 --destination-port 6443 --protocol tcp --health-check-http-domain kube-apiserver.selfmade4u.de --health-check-http-path "/livez?verbose" --health-check-http-response "livez check passed" --health-check-http-status-codes 200 --health-check-interval 3s --health-check-port 6443 --health-check-protocol http --health-check-retries 0 --health-check-timeout 2s --health-check-http-tls

# wait until all nodes have booted and then rebooted

ssh-keygen -R $(hcloud server ip node-1)
hcloud server ssh node-1

cat /var/log/cloud-init-output.log

kubeadm init --config /root/kubeadm-config.yaml --upload-certs --ignore-preflight-errors=Swap
mkdir -p /root/.kube/
cp /etc/kubernetes/admin.conf ~/.kube/config

# INSTALL CNI HERE - currently calico recommended

kubectl get pods --all-namespaces -w
exit

scp root@$(hcloud server ip node-1):/etc/kubernetes/admin.conf ~/.kube/config

ssh-keygen -R $(hcloud server ip node-2)
hcloud server ssh node-2
# use join command from above
mkdir -p /root/.kube/
cp /etc/kubernetes/admin.conf ~/.kube/config

ssh-keygen -R $(hcloud server ip node-3)
hcloud server ssh node-3
# use join command from above
mkdir -p /root/.kube/
cp /etc/kubernetes/admin.conf ~/.kube/config

kubectl get nodes

kubectl taint nodes node-1 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-2 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-3 node-role.kubernetes.io/master:NoSchedule-

hcloud server enable-protection node-1 delete rebuild
hcloud server enable-protection node-2 delete rebuild
hcloud server enable-protection node-3 delete rebuild

hcloud load-balancer enable-protection load-balancer delete








https://github.com/kubernetes-sigs/metrics-server

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl edit deploy -n kube-system metrics-server
# spec.template.spec.containers.args
# - --kubelet-insecure-tls

kubectl -n kube-system logs metrics-server-6dfddc5fb8-mjgpv

kubectl top node



TODO REALLY IMPORTANT https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/node/node-allocatable.md#recommended-cgroups-setup

https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/

sudo systemctl status system.slice # 994.2M (TODO later move containerd, kubelet which should not be there to other control group)

sudo systemctl status kubepods.slice # 6.1G limit 7.6

https://kubernetes.io/docs/tasks/administer-cluster/reconfigure-kubelet/

https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
apt update
apt-get install -y --allow-change-held-packages kubeadm=1.22.0-00


# for first node
kubeadm upgrade plan # take note of required manual updates
kubeadm upgrade apply --config /root/kubeadm-config.yaml v1.22.0


# for other nodes
sudo kubeadm upgrade node


apt-get install -y --allow-change-held-packages kubelet=1.22.0-00 kubectl=1.22.0-00
sudo systemctl daemon-reload
sudo systemctl restart kubelet


kubectl get nodes







https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/


https://kubernetes.io/docs/concepts/containers/runtime-class/#hahahugoshortcode-s3-hbhb


# ----------------- old notes -------------------------

# TODO https://www.hetzner.com/dns-console
# https://dns.hetzner.com/api-docs

later: use load balancer, now: add dns to node-1 kube-apiserver.selfmade4u.de
https://github.com/kubernetes/kubeadm/blob/master/docs/ha-considerations.md#keepalived-and-haproxy

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# installing kubeadm, kubelet, kubectl

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#stacked-control-plane-and-etcd-nodes

# https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta3/
# https://pkg.go.dev/k8s.io/kubelet/config/v1beta1?utm_source=godoc#KubeletConfiguration

# on failure:
kubeadm reset
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
rm -R /etc/cni/net.d

# if already joined cluster:
# remove node using kubectl delete node to try again
# also remove from etcd (if automatic removal failed):
https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/
kubectl get pods --namespace kube-system -o wide | grep etcd
kubectl exec etcd-kubernetes-node-1 -n kube-system -- etcdctl --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt  --endpoints=23.88.58.221:2379,23.88.39.133:2379 member list
kubectl exec etcd-kubernetes-node-1 -n kube-system -- etcdctl --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt  --endpoints=23.88.58.221:2379,23.88.39.133:2379 member remove e5c87eae083faedd

kubectl logs -n kube-system kube-flannel-ds-6z5cf


# maintenance
kubectl drain node-1 --ignore-daemonsets --delete-emptydir-data
# do maintenance
kubectl uncordon node-1

```