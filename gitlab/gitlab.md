helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab --namespace gitlab --create-namespace -f gitlab-values.yaml 

https://docs.gitlab.com/charts/

kubectl -n gitlab get all

kubectl get secret <name>-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

kubectl -n gitlab describe issuer gitlab-issuer

# https://github.com/traefik/traefik-helm-chart/tree/master/traefik

kubectl -n kube-system port-forward $(kubectl -n kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

http://localhost:9000/dashboard/#/

hcloud server ssh -p 2222 node-1
cat /var/lib/rancher/k3s/server/manifests/traefik.yaml

nano /var/lib/rancher/k3s/server/manifests/traefik-config.yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: traefik
  namespace: kube-system
spec:
  valuesContent: |-
    hub:
      enabled: true
    ingressClass:
      enabled: true
      isDefaultClass: true
    logs:
      access: true


kubectl apply -f test.yaml

# https://traefik.selfmade4u.de/dashboard/