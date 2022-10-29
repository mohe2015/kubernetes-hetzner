# THIS SEEMS extremely broken, try official instructions:

# https://docs.joinmastodon.org/admin/prerequisites/

# their docker-compose is also broken

git clone git@github.com:mastodon/mastodon.git
cd mastodon
git checkout 7ccf7a73f1c47a8c03712c39f7c591e837cf6d08
cd chart
helm dep update
cd ../../..

kubectl create namespace mastodon

kubectl config set-context --current --namespace=mastodon

export RANDOm=$(openssl rand -base64 32)
kubectl create secret generic mastodon-secret --from-literal=SECRET_KEY_BASE=$RANDOM --from-literal=OTP_SECRET=$RANDOM --from-literal=VAPID_PRIVATE_KEY=$RANDOM --from-literal=VAPID_PUBLIC_KEY=$RANDOM --from-literal=postgresql-password=$RANDOM --from-literal=postgres-password=$RANDOM --from-literal=redis-password=$RANDOM --from-literal=password=$RANDOM

helm upgrade --install --debug --namespace mastodon --create-namespace mastodon ./mastodon/mastodon/chart -f ./mastodon/values.yaml

kubectl get pods --watch

https://mastodon.selfmade4u.de/

# delete all pods