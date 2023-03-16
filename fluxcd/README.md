https://fluxcd.io/flux/get-started/

https://fluxcd.io/flux/installation/#install-the-flux-cli

https://fluxcd.io/flagger/tutorials/gatewayapi-progressive-delivery/

```bash
curl -s https://fluxcd.io/install.sh | sudo bash

export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>

# fine-grained access token
# fluxcd
# create fleet-infra repo and select it
# allow all repository permissions

flux check --pre

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=fleet-infra \
  --branch=main \
  --interval=30s \
  --path=./clusters/my-cluster \
  --personal

git clone https://github.com/$GITHUB_USER/fleet-infra
cd fleet-infra

flux create source git projektwahl \
  --url=https://github.com/projektwahl/projektwahl-lit \
  --branch=kubernetes \
  --interval=30s \
  --export > ./clusters/my-cluster/projektwahl-source.yaml

flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --interval=5m \
  --export > ./clusters/my-cluster/podinfo-kustomization.yaml

# https://fluxcd.io/flux/components/kustomize/kustomization/
# TODO run https://github.com/fluxcd/flux2-multi-tenancy/blob/main/scripts/validate.sh

flux get source git --watch


```