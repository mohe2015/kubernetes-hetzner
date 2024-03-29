# https://argoproj.github.io/

# https://argoproj.github.io/cd/

https://argo-cd.readthedocs.io/en/stable/user-guide/helm/

https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd

helm repo add argo https://argoproj.github.io/argo-helm

helm upgrade -f argocd/values.yaml --install --create-namespace --namespace argocd argo-cd argo/argo-cd 

kubectl config set-context --current --namespace=argocd

#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f argocd/gateway.yaml

# https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough
# https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-2-multiple-ingress-objects-and-hosts

admin
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

argocd login argocd.selfmade4u.de

argocd app sync projektwahl --local /kubernetes

https://argocd-image-updater.readthedocs.io/en/stable/

# TODO FIXME declaratively create projektwahl project

kubectl apply -f argocd/github.yaml

https://argo-cd.readthedocs.io/en/stable/user-guide/ci_automation/

https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/services/github/

# github webhook

# TODO FIXME this probably needs the insecure option

# https://argo-cd.readthedocs.io/en/stable/operator-manual/tls/

kubectl -n argocd port-forward svc/argo-cd-argocd-applicationset-controller 7000:7000

127.0.0.1:7000

https://argocd-applicationsets.selfmade4u.de/api/webhook

application/json

Let me select individual events. 

Pull Requests