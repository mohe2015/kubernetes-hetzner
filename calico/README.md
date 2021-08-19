# https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises
# https://github.com/projectcalico/calico
https://github.com/projectcalico/cni-plugin
https://docs.projectcalico.org/getting-started/kubernetes/flannel/migration-from-flannel


curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml