# kubernetes-hetzner

see [kubeadm/README.md](kubeadm/README.md)

now optionally run sonobuoy for conformance tests

now see kubernetes-dashboard, contour, rook, zammad, prometheus, harbor, keycloak, vitess

## Issues

letsencrypt ratelimits

Priority classes and OOM

kubectl get pods --all-namespaces -o custom-columns=NAME:.metadata.name,PRIORITY:.spec.priorityClassName

## currently available services

https://rook-ceph.selfmade4u.de/

https://harbor.selfmade4u.de/

https://sso.selfmade4u.de/


for later: https://kubernetes.io/docs/tasks/debug-application-cluster/audit/
for later: https://kubernetes.io/docs/concepts/cluster-administration/logging/
for later: https://kubernetes.io/docs/tasks/debug-application-cluster/monitor-node-health/
for later: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-overhead/

for later https://docs.fluentd.org/container-deployment/kubernetes
hints: https://medium.com/kubernetes-tutorials/cluster-level-logging-in-kubernetes-with-fluentd-e59aa2b6093a