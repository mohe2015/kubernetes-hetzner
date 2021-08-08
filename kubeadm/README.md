```bash

# https://kubernetes.io/docs/reference/setup-tools/kubeadm/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

# TODO FIXME is kubernetes + etcd communicating encrypted?

https://github.com/hetznercloud/csi-driver
https://github.com/hetznercloud/hcloud-cloud-controller-manager

# install hcloud https://github.com/hetznercloud/cli
hcloud context create kubernetes

create three servers of type cpx11 (min 40GB disk)

hcloud server create --type cpx11 --image debian-10 --ssh-key moritz@nixos --user-data-from-file docs/kubernetes/kubeadm/cloud-init.yaml --name node-1 --datacenter nbg1-dc3
hcloud server create --type cpx11 --image debian-10 --ssh-key moritz@nixos --user-data-from-file docs/kubernetes/kubeadm/cloud-init.yaml --name node-2 --datacenter hel1-dc2
hcloud server create --type cpx11 --image debian-10 --ssh-key moritz@nixos --user-data-from-file docs/kubernetes/kubeadm/cloud-init.yaml --name node-3 --datacenter fsn1-dc14
# wait until all nodes have booted and then rebooted


hcloud server ssh node-1

kubeadm init --config /root/kubeadm-config.yaml --upload-certs #--ignore-preflight-errors=Swap
cp /etc/kubernetes/admin.conf ~/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl get pod -n kube-system -w

scp root@kubernetes-node-1.selfmade4u.de:/etc/kubernetes/admin.conf ~/.kube/config


hcloud server ssh node-2
# use join command from above

hcloud server ssh node-3
# use join command from above

kubectl get nodes

kubectl taint nodes node-1 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-2 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node-3 node-role.kubernetes.io/master:NoSchedule-

hcloud server enable-protection node-1 delete rebuild
hcloud server enable-protection node-2 delete rebuild
hcloud server enable-protection node-3 delete rebuild



# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#create-load-balancer-for-kube-apiserver

# create hetzner load balancer



# now see kubernetes-dashboard, rook, sonobuoy, harbor, keycloak, vitess





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
kubectl drain kubernetes-node-1 --ignore-daemonsets --delete-emptydir-data
# do maintenance
kubectl uncordon kubernetes-node-1

```