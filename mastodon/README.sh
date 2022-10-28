git clone --depth 1 git@github.com:mastodon/mastodon.git
cd mastodon/chart
helm dep update
cd ../..

kubectl create namespace mastodon

kubectl config set-context --current --namespace=mastodon

kubectl create secret generic mastodon-secret --from-literal=SECRET_KEY_BASE=$(openssl rand -base64 32) --from-literal=OTP_SECRET=$(openssl rand -base64 32) --from-literal=VAPID_PRIVATE_KEY=$(openssl rand -base64 32) --from-literal=VAPID_PUBLIC_KEY=$(openssl rand -base64 32) --from-literal=postgresql-password=$(openssl rand -base64 32) --from-literal=redis-password=$(openssl rand -base64 32)

helm install --debug --timeout 15m --namespace mastodon --create-namespace mastodon ./mastodon/mastodon/chart -f ./mastodon/values.yaml