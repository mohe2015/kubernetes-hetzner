https://linkerd.io/2.12/getting-started/

https://linkerd.io/2.12/tasks/install-helm/

https://linkerd.io/2.12/tasks/generate-certificates/

helm repo add linkerd https://helm.linkerd.io/stable

#step-cli certificate create root.linkerd.cluster.local ca.crt ca.key --profile root-ca --no-password --insecure --not-after=87600h

#step-cli certificate create identity.linkerd.cluster.local issuer.crt issuer.key --profile intermediate-ca --not-after 8760h --no-password --insecure --ca ca.crt --ca-key ca.key

# maybe some tokens are not created with helm. at least that was one thing I saw

#helm upgrade linkerd-cni linkerd/linkerd2-cni --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --namespace linkerd-cni

# actually do this
linkerd check --pre

#helm upgrade linkerd-crds linkerd/linkerd-crds --create-namespace --install --reset-values --namespace linkerd
linkerd install --crds | kubectl apply -f -
linkerd check --crds

#helm upgrade linkerd-control-plane linkerd/linkerd-control-plane --install --reset-values --set-file identityTrustAnchorsPEM=ca.crt --set-file identity.issuer.tls.crtPEM=issuer.crt --set-file identity.issuer.tls.keyPEM=issuer.key --namespace linkerd

linkerd install | kubectl apply -f -
linkerd check

#helm install linkerd-viz linkerd/linkerd-viz
linkerd viz install | kubectl apply -f -
linkerd viz check
linkerd viz dashboard

# uninstall
# linkerd uninstall | kubectl delete -f -
# kubectl delete ns linkerd
# kubectl delete ns linkerd-cni