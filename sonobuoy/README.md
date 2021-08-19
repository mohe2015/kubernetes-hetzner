```bash

# doesn't work with flannel

sonobuoy gen
https://sonobuoy.io/docs/v0.53.2/gen/

https://github.com/cncf/k8s-conformance/blob/master/instructions.md
# warning: probably needs more memory and not much else running at the same time
sonobuoy run --mode quick --timeout=600000
sonobuoy run --mode non-disruptive-conformance --timeout=600000
sonobuoy run --mode=certified-conformance --timeout=600000 # DISRUPTIVE
# sonobuoy run --mode=certified-conformance --timeout=30000 # probably need to increase timeout
sonobuoy status
#  watch 'sonobuoy status --json | json_pp'
sonobuoy logs -f
export outfile=$(sonobuoy retrieve)
sonobuoy results $outfile
sonobuoy e2e $outfile # doesnt work so probably result reporting failed?
sonobuoy results $outfile --plugin e2e # --mode=detailed

/*
Plugin: e2e
Status: failed
Total: 6432
Passed: 344
Failed: 2
Skipped: 6086

Failed tests:
[sig-apps] CronJob should not schedule new jobs when ForbidConcurrent [Slow] [Conformance]
[sig-api-machinery] AdmissionWebhook [Privileged:ClusterAdmin] should be able to deny attaching pod [Conformance]

Plugin: systemd-logs
Status: passed
Total: 3
Passed: 3
Failed: 0
Skipped: 0
*/

# https://sonobuoy.io/simplified-results-reporting-with-sonobuoy/
sonobuoy results $outfile --mode=detailed --node=node-x --plugin systemd-logs --skip-prefix
# for me this showed that two of the nodes failed logging

https://sonobuoy.io/docs/v0.52.0/faq/

sonobuoy results --mode detailed --plugin e2e $outfile |  jq '.  | select(.status == "failed") | .details'

sonobuoy delete --wait


kubectl --insecure-skip-tls-verify get nodes

https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/

kubeadm certs check-expiration
kubeadm certs renew all
kubeadm certs renew apiserver --config /root/kubeadm-config.yaml
```