# IMPORTANT Always use a virtual machine when testing Rook. Never use your host system where local devices may mistakenly be consumed.

https://rook.io/docs/rook/v1.11/CRDs/Cluster/pvc-cluster/

helm repo add rook-release https://charts.rook.io/release

# https://rook.io/docs/rook/v1.11/Helm-Charts/operator-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph -f rook/values-rook-ceph.yaml

kubectl --namespace rook-ceph get pods -l "app=rook-ceph-operator" --watch

kubectl --namespace rook-ceph logs -l "app=rook-ceph-operator" -f

# https://rook.io/docs/rook/v1.11/Helm-Charts/ceph-cluster-chart/
helm upgrade --install --create-namespace --namespace rook-ceph rook-ceph-cluster rook-release/rook-ceph-cluster -f rook/values-rook-ceph-cluster.yaml

kubectl --namespace rook-ceph get cephcluster --watch

https://rook.io/docs/rook/v1.11/Storage-Configuration/Monitoring/ceph-dashboard/?h=dashboard#enable-the-ceph-dashboard

kubectl apply -f rook/gateway.yaml

# username: admin
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo

https://ceph-dashboard.selfmade4u.de/

# restart the operator if something is broken
kubectl -n rook-ceph delete pod -l app=rook-ceph-operator

# debug tools

kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
