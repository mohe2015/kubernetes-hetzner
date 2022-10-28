hcloud server ssh -p 2222 node-1

nano /var/lib/rancher/k3s/server/manifests/traefik-config.yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: traefik
  namespace: kube-system
spec:
  valuesContent: |-
    ingressClass:
      enabled: true
      isDefaultClass: true

kubectl get ingressclasses --all-namespaces

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade gitlab gitlab/gitlab --atomic --install --namespace gitlab --create-namespace -f gitlab-values.yaml

kubectl get ingress --all-namespaces # check that it shows an address everywhere

https://docs.gitlab.com/charts/

kubectl -n gitlab get all

# username: root
kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

kubectl -n gitlab describe issuer gitlab-issuer

# https://github.com/traefik/traefik-helm-chart/tree/master/traefik

kubectl -n kube-system port-forward $(kubectl -n kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

http://localhost:9000/dashboard/#/
