
https://github.com/flannel-io/flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.14.0/Documentation/kube-flannel.yml
kubectl get pod -n kube-system -w

https://github.com/flannel-io/flannel/issues/1408
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=968457