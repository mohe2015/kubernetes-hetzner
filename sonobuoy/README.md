
https://github.com/cncf/k8s-conformance/blob/master/instructions.md
# warning: probably needs more memory and not much else running at the same time
sonobuoy run --mode=certified-conformance
sonobuoy status
sonobuoy logs
outfile=$(sonobuoy retrieve)
sonobuoy delete