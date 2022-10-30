#!/bin/sh
cat > base.yaml
exec kubectl kustomize ./istio # you can also use "kustomize build ." if you have it installed.
