```bash
# CURRENTLY NOT USABLE AS IT'S NOT COMPATIBLE WITH kubernetes 1.22

https://projectcontour.io/getting-started/

# https://projectcontour.io/docs/v1.18.0/deploy-options/#running-without-a-kubernetes-loadbalancer
# we change LoadBalancer to NodePort as we use an external LoadBalancer (for now)
curl -OL https://projectcontour.io/quickstart/contour.yaml

kubectl apply -f contour.yaml

https://projectcontour.io/guides/cert-manager/
"You must deploy at least one Ingress object before Contour can configure Envoy to serve traffic. Note that as a security feature, Contour does not configure Envoy to expose a port to the internet unless there’s a reason it should. For this tutorial we deploy a version of Kenneth Reitz’s httpbin.org service."

kubectl apply -f https://projectcontour.io/examples/httpbin.yaml
kubectl get po -l app=httpbin

# now add these to hetzner load balancer
kubectl get -n projectcontour service envoy -o wide

http://kube-apiserver.selfmade4u.de/

# we need the beta
curl -OL https://github.com/jetstack/cert-manager/releases/download/v1.4.3/cert-manager.yaml
kubectl apply -f cert-manager.yaml

# REMEMBER TO CHANGE THE EMAIL-ADRESS IN letsencrypt-staging.yaml

#kubectl apply -f letsencrypt-staging.yaml
#kubectl delete certificate httpbin
#kubectl delete secret httpbin

# REMEMBER TO CHANGE THE EMAIL-ADRESS IN letsencrypt-prod.yaml

kubectl apply -f letsencrypt-prod.yaml

kubectl -n cert-manager logs -l app=cert-manager -c cert-manager

kubectl apply -f deployment.yaml

kubectl get pod -l app=httpbin

kubectl apply -f service.yaml

kubectl get service httpbin

kubectl apply -f ingress.yaml

kubectl get ingress httpbin

kubectl describe certificate httpbin | tail -n 12

kubectl describe certificate httpbin | grep -C3 "Certificate is up to date"

kubectl get secret httpbin

kubectl delete -f ingress.yaml -f service.yaml -f deployment.yaml -f letsencrypt-staging.yaml

# https://projectcontour.io/docs/v1.16.0/config/annotations/

# https://github.com/jetstack/cert-manager/issues/3682

```