lsblk -f

helm repo add rook-release https://charts.rook.io/release

# https://rook.io/docs/rook/v1.10/Helm-Charts/operator-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph -f rook/values.yaml

# https://rook.io/docs/rook/v1.10/Helm-Charts/ceph-cluster-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph-cluster rook-release/rook-ceph-cluster -f rook/values.yaml

kubectl -n rook-ceph get all