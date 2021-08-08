```bash

https://github.com/ory/kratos
https://github.com/ory/k8s

https://www.keycloak.org/getting-started/getting-started-kube
\# also has an operator

wget -q -O - https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak-ingress.yaml | \
sed "s/KEYCLOAK_HOST/keycloak.local/" | \
kubectl create -f -

username: admin
password: admin

http://keycloak.local/auth/realms/not-grocy/account/#/

add client scopes for all permissions

clients->client scopes->setup add client scopes to default

Consent Required

access type: confidential https://www.keycloak.org/docs/latest/authorization_services/
authorization enabled

authorization -> resources -> new -> stock


maybe use roles?


https://www.keycloak.org/app/

https://stackoverflow.com/questions/42186537/resources-scopes-permissions-and-policies-in-keycloak

```