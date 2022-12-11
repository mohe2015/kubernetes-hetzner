# STREAMING ENDPOINT IS STILL BROKEN

# https://docs.joinmastodon.org/admin/prerequisites/

# their docker-compose is also broken

git clone git@github.com:mastodon/mastodon.git
cd mastodon
cd chart
helm dep update
cd ../../..

kubectl create namespace mastodon
kubectl label namespace mastodon istio-injection=enabled

kubectl config set-context --current --namespace=mastodon

kubectl create secret generic mastodon-secret --from-literal=SECRET_KEY_BASE=$(openssl rand -base64 32) --from-literal=OTP_SECRET=$(openssl rand -base64 32) --from-literal=VAPID_PRIVATE_KEY=$(openssl rand -base64 32) --from-literal=VAPID_PUBLIC_KEY=$(openssl rand -base64 32) --from-literal=redis-password=$(openssl rand -base64 32) --from-literal=password=$(openssl rand -base64 32) --from-literal=postgres-password=$(openssl rand -base64 32)

helm upgrade --install --debug --namespace mastodon --create-namespace mastodon ./mastodon/mastodon/chart -f ./mastodon/values.yaml

kubectl get pods --watch

https://mastodon.selfmade4u.de/

kubectl exec -it deployment/mastodon-web -- tootctl accounts create moritz_hedtke --email=Moritz.Hedtke@t-online.de --confirmed --role=Owner