#!/bin/sh
cat > ./istio/base.yaml
exec kubectl kustomize ./istio # you can also use "kustomize build ." if you have it installed.
