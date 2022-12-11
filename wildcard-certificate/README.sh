lego --email Moritz.Hedtke@t-online.de --dns hetzner --domains 'selfmade4u.de,*.selfmade4u.de,*.default.knative.selfmade4u.de' run

kubectl create namespace istio-system
kubectl -n istio-system create secret tls selfmade4u.de-wildcard-certificate --dry-run=client -o yaml --save-config --cert=.lego/certificates/selfmade4u.de.crt --key=.lego/certificates/selfmade4u.de.key | kubectl apply -f -
