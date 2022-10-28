git clone --depth 1 git@github.com:mastodon/mastodon.git
cd mastodon/chart
helm dep update
cd ../..

kubectl create namespace mastodon

kubectl config set-context --current --namespace=mastodon

export POSTGRES_PASSWORD=$(openssl rand -base64 32)
kubectl create secret generic mastodon-secret --from-literal=SECRET_KEY_BASE=$(openssl rand -base64 32) --from-literal=OTP_SECRET=$(openssl rand -base64 32) --from-literal=VAPID_PRIVATE_KEY=$(openssl rand -base64 32) --from-literal=VAPID_PUBLIC_KEY=$(openssl rand -base64 32) --from-literal=postgresql-password=$POSTGRES_PASSWORD --from-literal=postgres-password=$POSTGRES_PASSWORD --from-literal=redis-password=$(openssl rand -base64 32)

helm upgrade --install --debug --namespace mastodon --create-namespace mastodon ./mastodon/mastodon/chart -f ./mastodon/values.yaml

https://mastodon.selfmade4u.de/

# delete all pods