https://linkerd.io/2.12/getting-started/

https://linkerd.io/2.12/tasks/install-helm/

https://linkerd.io/2.12/tasks/generate-certificates/

helm repo add linkerd https://helm.linkerd.io/stable

step-cli certificate create root.linkerd.cluster.local ca.crt ca.key --profile root-ca --no-password --insecure --not-after=87600h

step-cli certificate create identity.linkerd.cluster.local issuer.crt issuer.key --profile intermediate-ca --not-after 8760h --no-password --insecure --ca ca.crt --ca-key ca.key

helm upgrade linkerd-cni linkerd/linkerd2-cni --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --namespace linkerd-cni

# linkerd check --pre --linkerd-cni-enabled

helm upgrade linkerd-crds lilinkerd/linkerd-crds --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --values values-crds.yaml --namespace linkerd

helm upgrade linkerd-base linkerd/linkerd-base --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --namespace linkerd


helm upgrade linkerd-control-plane linkerd/linkerd-control-plane --atomic --cleanup-on-fail --create-namespace --dependency-update --install --render-subchart-notes --reset-values --values values-control-plane.yaml --set-file identityTrustAnchorsPEM=ca.crt --set-file identity.issuer.tls.crtPEM=issuer.crt  --set-file identity.issuer.tls.keyPEM=issuer.key --namespace linkerd

helm repo update

helm search repo linkerd

# TODO FIXMe store the above in values.yml and add values.yaml here
helm upgrade linkerd-crds linkerd/linkerd-crds
helm upgrade linkerd-control-plane linkerd/linkerd-control-plane --reset-values -f values.yaml --atomic


