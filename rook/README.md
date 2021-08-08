```bash

https://rook.io/docs/rook/v1.7/ceph-quickstart.html
git clone --single-branch --branch v1.7.0 https://github.com/rook/rook.git
cd rook/cluster/examples/kubernetes/ceph
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
#kubectl create -f cluster-test.yaml # don't do this this is probably fucking dangerous as it's trying to use all devices
kubectl create -f cluster.yaml
kubectl -n rook-ceph get pod

https://rook.io/docs/rook/v1.7/ceph-osd-mgmt.html
https://rook.io/docs/rook/v1.7/ceph-cluster-crd.html
\# GPT is not supported as disk format use MSDOS
#kubectl create -f rook/host-based-cluster.yaml


https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/
#kubectl get storageclass
#kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
#kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


https://rook.io/docs/rook/v1.7/ceph-toolbox.html
kubectl create -f rook/toolbox.yaml 
kubectl -n rook-ceph rollout status deploy/rook-ceph-tools
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash

ceph health
ceph status
ceph osd status
ceph df

kubectl -n rook-ceph delete deploy/rook-ceph-tools


https://rook.io/docs/rook/v1.7/ceph-dashboard.html
kubectl create -f rook/dashboard-external-https.yaml
kubectl -n rook-ceph get service
# any node use port 32599
# https://kubernetes-node-1.selfmade4u.de:32599/
# TODO FIXME undo this about:config network.stricttransportsecurity.preloadlist
# TODO use ingress
# username: admin
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo


https://rook.io/docs/rook/v1.7/ceph-object.html
this only seems to work with 3 nodes...
kubectl create -f docs/kubernetes/rook/object.yaml
kubectl -n rook-ceph get pod -l app=rook-ceph-rgw
kubectl create -f docs/kubernetes/rook/bucket.yaml
kubectl create -f docs/kubernetes/rook/bucket-claim.yaml



https://rook.io/docs/rook/v1.7/ceph-block.html
#kubectl create -f rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass-test.yaml
kubectl create -f rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml



https://rook.io/docs/rook/v1.7/ceph-filesystem.html
#kubectl create -f rook/cluster/examples/kubernetes/ceph/filesystem-test.yaml
kubectl create -f rook/cluster/examples/kubernetes/ceph/filesystem.yaml
kubectl -n rook-ceph get pod -l app=rook-ceph-mds
kubectl create -f rook/cluster/examples/kubernetes/ceph/csi/cephfs/storageclass.yaml




# TODO FIXME make the other one default as some nodes seem to want to attach the disk to multiple pods
kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get storageclass




















https://rook.io/docs/rook/v1.7/ceph-teardown.html

rm -R /var/lib/rook







## On node removal
https://rook.io/docs/rook/v1.7/ceph-osd-mgmt.html

https://kubernetes-node-1.selfmade4u.de:32599/#/osd

mark osd lost
destroy, purge?

kubectl delete deployment -n rook-ceph rook-ceph-osd-<ID>










ceph config set mon mon_data_avail_warn 15



https://rook.io/docs/rook/v1.7/ceph-common-issues.html



# Move and resize disk

```