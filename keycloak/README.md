```bash

# TODO FIXME properly save database

https://github.com/ory/kratos
https://github.com/ory/k8s

https://www.keycloak.org/getting-started/getting-started-kube
\# also has an operator

kubectl create -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak.yaml

https://github.com/keycloak/keycloak-containers/blob/15.0.1/server/README.md#database

# https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak-ingress.yaml

# DB_VENDOR=mariadb
# DB_ADDR
# DB_DATABASE
# DB_USER
# DB_PASSWORD

kubectl apply -f keycloak/keycloak-ingress.yaml

username: admin
password: admin

# change password

```