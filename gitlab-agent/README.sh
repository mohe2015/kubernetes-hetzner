helm repo add gitlab https://charts.gitlab.io
helm repo update
helm upgrade --install gitlab gitlab/gitlab-agent \
    --namespace gitlab-agent \
    --create-namespace \
    --set image.tag=v15.5.1 \
    --set config.token=EBXxSHEPnWFP6oMJpzRkFE8cZxHthsAayeVSgdLEKrX-M4e9PA \
    --set config.kasAddress=wss://kas.selfmade4u.de

# https://docs.gitlab.com/ee/user/clusters/agent/
# https://docs.gitlab.com/ee/user/clusters/agent/gitops.html
# https://docs.gitlab.com/ee/user/clusters/agent/gitops/helm.html