
# CRITIAL: Do this next:
# TODO all nodes here should run "guaranteed" as this is a really essential service.
# TODO https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/
# https://github.com/rook/rook/blob/fcf634e3b7808e4338e7fd261c047aae4793e99b/design/ceph/resource-constraints.md

# kubectl get priorityclasses.scheduling.k8s.io
# priorityClassName: system-cluster-critical

# https://github.com/rook/rook

# TODO USE https://github.com/rook/rook/blob/master/Documentation/helm-ceph-cluster.md
# TODO USE https://github.com/rook/rook/blob/master/Documentation/helm-operator.md

https://rook.io/docs/rook/v1.7/ceph-quickstart.html
git clone --single-branch --branch v1.7.1 https://github.com/rook/rook.git repos/rook

kubectl apply -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/crds.yaml -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/common.yaml -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/operator.yaml

# wait for operator to start
kubectl -n rook-ceph get pod -w

curl -OL https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl apply -f cluster.yaml # warning: this will try to use all unformatted partitions and devices of your host for rook storage.
kubectl -n rook-ceph get pod -w

https://rook.io/docs/rook/v1.7/ceph-osd-mgmt.html
https://rook.io/docs/rook/v1.7/ceph-cluster-crd.html


https://rook.io/docs/rook/v1.7/ceph-toolbox.html
kubectl apply -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/toolbox.yaml
kubectl -n rook-ceph rollout status deploy/rook-ceph-tools
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash

ceph health
ceph status
ceph osd status
ceph df

kubectl -n rook-ceph delete deploy/rook-ceph-tools


https://rook.io/docs/rook/v1.7/ceph-dashboard.html
kubectl apply -f rook/dashboard-ingress-https.yaml
kubectl -n rook-ceph get ingress

https://rook-ceph.selfmade4u.de/

kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo


https://rook.io/docs/rook/v1.7/ceph-block.html
#kubectl create -f repos/rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass-test.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml



https://rook.io/docs/rook/v1.7/ceph-filesystem.html
#kubectl create -f rook/cluster/examples/kubernetes/ceph/filesystem-test.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/filesystem.yaml
kubectl -n rook-ceph get pod -l app=rook-ceph-mds -w
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/csi/cephfs/storageclass.yaml


https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/
kubectl get storageclass
kubectl patch storageclass rook-cephfs -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get storageclass


https://rook.io/docs/rook/v1.7/ceph-object.html
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/object-user.yaml -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/object.yaml
kubectl -n rook-ceph get pod -l app=rook-ceph-rgw -w
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/storageclass-bucket-retain.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.7.1/cluster/examples/kubernetes/ceph/object-bucket-claim-retain.yaml

export AWS_HOST=$(kubectl -n default get cm ceph-retain-bucket -o jsonpath='{.data.BUCKET_HOST}') # withouth .svc?
# AWS_ENDPOINT
kubectl -n rook-ceph get svc rook-ceph-rgw-my-store
export AWS_ACCESS_KEY_ID=$(kubectl -n default get secret ceph-retain-bucket -o jsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode)
export AWS_SECRET_ACCESS_KEY=$(kubectl -n default get secret ceph-retain-bucket -o jsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode)
echo "export AWS_HOST=$AWS_HOST"
echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"


kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
# set the four env vars
yum --assumeyes install s3cmd
echo "Hello Rook" > /tmp/rookObj
s3cmd put /tmp/rookObj --no-ssl --host=${AWS_HOST} --host-bucket= s3://ceph-bkt-63c510f8-513f-4ad1-9896-42e227ee159f
s3cmd get s3://ceph-bkt-63c510f8-513f-4ad1-9896-42e227ee159f/rookObj /tmp/rookObj-download --no-ssl --host=${AWS_HOST} --host-bucket=
cat /tmp/rookObj-download
s3cmd ls s3://ceph-bkt-63c510f8-513f-4ad1-9896-42e227ee159f --no-ssl --host=${AWS_HOST} --host-bucket=






# Restart operator (fixes anything ^^)
kubectl -n rook-ceph delete pod -l app=rook-ceph-operator














https://rook.io/docs/rook/v1.7/ceph-teardown.html





shred -v -n 1 /dev/sdREMOVEa2
rm -R /var/lib/rook





## On node removal
https://rook.io/docs/rook/v1.7/ceph-osd-mgmt.html

https://kubernetes-node-1.selfmade4u.de:32599/#/osd

mark osd lost
destroy, purge?

kubectl delete deployment -n rook-ceph rook-ceph-osd-<ID>








ceph config set mon mon_allow_pool_delete true

ceph config set mon mon_data_avail_warn 15



https://rook.io/docs/rook/v1.7/ceph-common-issues.html


https://github.com/rook/rook/issues/5028



# Move and resize disk
