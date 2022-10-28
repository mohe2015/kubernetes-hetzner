lsblk -f

helm repo add rook-release https://charts.rook.io/release

# https://rook.io/docs/rook/v1.10/Helm-Charts/operator-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph -f rook/values.yaml

# https://rook.io/docs/rook/v1.10/Helm-Charts/ceph-cluster-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph-cluster rook-release/rook-ceph-cluster -f rook/values.yaml

kubectl -n rook-ceph get all

https://rook.io/docs/rook/v1.10/Storage-Configuration/Monitoring/ceph-dashboard/

# username: admin
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
