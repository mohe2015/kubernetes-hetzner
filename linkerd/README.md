https://linkerd.io/2.12/getting-started/

https://linkerd.io/2.12/tasks/install-helm/

https://linkerd.io/2.12/tasks/generate-certificates/

helm repo add linkerd https://helm.linkerd.io/stable

step-cli certificate create root.linkerd.cluster.local ca.crt ca.key --profile root-ca --no-password --insecure --not-after=87600h

step-cli certificate create identity.linkerd.cluster.local issuer.crt issuer.key --profile intermediate-ca --not-after 8760h --no-password --insecure --ca ca.crt --ca-key ca.key

helm install linkerd-cni -n linkerd-cni --create-namespace linkerd/linkerd2-cni

linkerd check --pre --linkerd-cni-enabled

helm install linkerd-crds linkerd/linkerd-crds -n linkerd --create-namespace --set cniEnabled=true

helm install linkerd-base -n linkerd linkerd/linkerd-base

helm install linkerd-control-plane -n linkerd \
  --set-file identityTrustAnchorsPEM=ca.crt \
  --set-file identity.issuer.tls.crtPEM=issuer.crt \
  --set-file identity.issuer.tls.keyPEM=issuer.key \
  --set cniEnabled=true \
  linkerd/linkerd-control-plane


helm repo update

helm search repo linkerd

# TODO FIXMe store the above in values.yml and add values.yaml here
helm upgrade linkerd-crds linkerd/linkerd-crds
helm upgrade linkerd-control-plane linkerd/linkerd-control-plane --reset-values -f values.yaml --atomic


