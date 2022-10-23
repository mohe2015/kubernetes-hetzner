```bash

git clone https://github.com/vitessio/vitess.git
kubectl apply -f vitess/examples/operator/operator.yaml
#kubectl apply -f vitess/examples/operator/101_initial_cluster.yaml
kubectl apply -f vitess/examples/operator/vtorc_example.yaml

\# vtorc
kubectl port-forward deployment/example-commerce-x-x-zone1-vtorc-c13ef6ff 3001:3000
http://localhost:3001
\# this is epic - you can graphically see the hierarchy and promote primaries etc.

./vitess/examples/operator/pf.sh

http://localhost:15000/app/

nix shell nixpkgs#mariadb-client nixpkgs#go
go get vitess.io/vitess/go/cmd/vtctlclient

alias vtctlclient="~/go/bin/vtctlclient -server=localhost:15999"
alias mysql="mysql -h 127.0.0.1 -P 15306 -u user"

kubectl get pods

vtctlclient ApplySchema -sql="$(cat vitess/examples/operator/create_commerce_schema.sql)" commerce
vtctlclient ApplyVSchema -vschema="$(cat vitess/examples/operator/vschema_commerce_initial.json)" commerce

https://vitess.io/docs/user-guides/schema-changes/unmanaged-schema-changes/

https://github.com/github/gh-ost/blob/master/doc/why-triggerless.md

```