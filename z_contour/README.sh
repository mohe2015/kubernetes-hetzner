# TODO FIXME make this high priority and Guaranteed

# potentially buggy? envoy crashes quite often but maybe this is because of general node overload?

# https://projectcontour.io/getting-started/

# https://projectcontour.io/docs/v1.18.0/deploy-options/#running-without-a-kubernetes-loadbalancer
# we change LoadBalancer to NodePort as we use an external LoadBalancer (for now)
# curl -OL https://projectcontour.io/quickstart/contour.yaml

kubectl apply -f contour/contour.yaml

# https://projectcontour.io/guides/cert-manager/
# "You must deploy at least one Ingress object before Contour can configure Envoy to serve traffic. Note that as a security feature, Contour does not configure Envoy to expose a port to the internet unless there’s a reason it should. For this tutorial we deploy a version of Kenneth Reitz’s httpbin.org service."

#kubectl apply -f https://projectcontour.io/examples/httpbin.yaml
#kubectl get po -l app=httpbin

# now add these to hetzner load balancer
# kubectl get -n projectcontour service envoy -o wide

# http://kube-apiserver.selfmade4u.de/

# https://cert-manager.io/docs/installation/
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.1/cert-manager.yaml

# REMEMBER TO CHANGE THE EMAIL-ADRESS IN letsencrypt-prod.yaml and letsencrypt-staging.yaml

kubectl apply -f contour/letsencrypt-staging.yaml
kubectl apply -f contour/letsencrypt-prod.yaml

kubectl -n cert-manager logs -l app=cert-manager -c cert-manager

# https://projectcontour.io/docs/v1.16.0/config/annotations/

# https://github.com/jetstack/cert-manager/issues/3682

hcloud load-balancer add-service load-balancer --listen-port 443 --destination-port 30443 --protocol tcp
hcloud load-balancer update-service load-balancer --listen-port 443 --destination-port 30443 --protocol tcp --health-check-interval 3s --health-check-port 30443 --health-check-protocol tcp --health-check-retries 0 --health-check-timeout 2s

hcloud load-balancer add-service load-balancer --listen-port 80 --destination-port 30080 --protocol tcp
hcloud load-balancer update-service load-balancer --listen-port 80 --destination-port 30080 --protocol tcp --health-check-interval 3s --health-check-port 30080 --health-check-protocol tcp --health-check-retries 0 --health-check-timeout 2s

# TODO FIXME pass ip forward

## FIXES

# kubectl -n projectcontour get pods -l app=envoy

# kubectl logs envoy-7tklv -n projectcontour envoy

# kubectl -n projectcontour delete pods -l app=envoy
