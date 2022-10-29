lsblk -f

helm repo add rook-release https://charts.rook.io/release

# https://rook.io/docs/rook/v1.10/Helm-Charts/operator-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph -f rook/values.yaml

kubectl --namespace rook-ceph get pods -l "app=rook-ceph-operator" --watch

# https://rook.io/docs/rook/v1.10/Helm-Charts/ceph-cluster-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph-cluster rook-release/rook-ceph-cluster -f rook/values.yaml

kubectl -n rook-ceph get pods --watch

https://rook.io/docs/rook/v1.10/Storage-Configuration/Monitoring/ceph-dashboard/

# username: admin
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo

https://ceph-dashboard.selfmade4u.de/

kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash

https://rook.io/docs/rook/v1.10/Troubleshooting/direct-tools/

kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.10/deploy/examples/direct-mount.yaml

kubectl -n rook-ceph get pod -l app=rook-direct-mount

kubectl -n rook-ceph exec -it <pod> -- bash

rbd create ceph-blockpool/test --size 10

rbd info ceph-blockpool/test

rbd feature disable ceph-blockpool/test fast-diff deep-flatten object-map

# repeat from here

rbd map ceph-blockpool/test

# don't do this again
mkfs.ext4 -m0 /dev/rbd7

mkdir -p /tmp/rook-volume
mount /dev/rbd7 /tmp/rook-volume

echo "Hello Rook" > /tmp/rook-volume/hello
cat /tmp/rook-volume/hello

umount /tmp/rook-volume
rbd unmap /dev/rbd7


# Create the directory
mkdir /tmp/registry

# Detect the mon endpoints and the user secret for the connection
mon_endpoints=$(grep mon_host /etc/ceph/ceph.conf | awk '{print $3}')
my_secret=$(grep key /etc/ceph/keyring | awk '{print $3}')

# Mount the filesystem
mount -t ceph -o mds_namespace=ceph-filesystem,name=admin,secret=$my_secret $mon_endpoints:/ /tmp/registry

# See your mounted filesystem
df -h

ls /tmp/registry

echo "Hello Rook" > /tmp/registry/hello
cat /tmp/registry/hello

# delete the file when you're done
rm -f /tmp/registry/hello

umount /tmp/registry
rmdir /tmp/registry
