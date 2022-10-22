# kubernetes-hetzner

see [kubeadm/README.md](kubeadm/README.md)

now optionally run sonobuoy for conformance tests

now see kubernetes-dashboard, cert-manager, istio, rook, zammad, prometheus, harbor, keycloak, vitess

## Issues

letsencrypt ratelimits

Priority classes and OOM

kubectl get pods --all-namespaces -o custom-columns=NAME:.metadata.name,PRIORITY:.spec.priorityClassName


cpu quota is usually wrong:

kube-system: is 3 should be 1
zammad: is 1.5 should be 0.5
monitoring: is 1.33 should be 0.5
rookceph: is 0.1 should be 0.5

TODO https://github.com/kubernetes/node-problem-detector

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