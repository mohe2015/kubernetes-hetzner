```bash
# DONTUSEYET: Not working well

# sometimes the kubernetes scheduler is really bad - maybe this can be improved
https://kubernetes.io/docs/reference/scheduling/config/

git clone https://github.com/kubernetes-sigs/descheduler repos/descheduler



kubectl create -f repos/descheduler/kubernetes/base/rbac.yaml
#kubectl create -f repos/descheduler/kubernetes/base/configmap.yaml
kubectl apply -f descheduler/configmap.yaml
kubectl create -f repos/descheduler/kubernetes/cronjob/cronjob.yaml


kubectl delete -f  repos/descheduler/kubernetes/cronjob/cronjob.yaml

```