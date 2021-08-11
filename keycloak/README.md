```bash

# TODO FIXME properly save database

https://github.com/ory/kratos
https://github.com/ory/k8s

https://www.keycloak.org/getting-started/getting-started-kube
\# also has an operator

kubectl create -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak.yaml

# https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak-ingress.yaml

kubectl apply -f keycloak/keycloak-ingress.yaml

username: admin
password: admin

# change password

# IGNORE BELOW - I NEED TO MOVE THIS SOMEWHERE ELSE

# create realm

# Roles -> Add Role -> add roles for permissions
# stock:view, stock:edit

# Clients -> Create
# access type: confidential
# authorization enabled
# Consent Required

# Authorization -> Authorization Scopes -> Create
# stock:view, stock:edit

# Resources -> Create
# stock
# add scopes to resource: stock:view, stock:edit


# Policies:
# Role Policy
# Name: stock:view
# Realm Roles: stock:view
# Maybe required?
# select client


# Permissions:
# Create -> Scope-Based
# perm:stock:view
# resource: stock
# scopes: stock:view
# policy: stock:view


# Users -> Create
# test-noperms

# Client -> Authorization -> Evaluate
# user: test-noperms
# roles: stock:view
# resources: stock
# scopes: stock:view


# https://medium.com/@harsh.manvar111/keycloak-authorization-service-rbac-1c3204a33a50

# https://www.keycloak.org/docs/latest/authorization_services/

https://www.keycloak.org/docs/latest/authorization_services/

https://github.com/keycloak/keycloak-quickstarts/tree/latest/app-authz-uma-photoz

User-Managed Access also be interesting

https://sso.selfmade4u.de/auth/realms/not-grocy/account/#/

https://sso.selfmade4u.de/auth/realms/not-grocy/.well-known/openid-configuration

# secret from Client -> Credentials
https://sso.selfmade4u.de/auth/realms/not-grocy/protocol/openid-connect/auth?response_type=code&client_id=not-grocy&client_secret=505f2a0c-2f5a-4f0f-960a-f397f342c651&redirect_url=https://test.selfmade4u.de

# Realm -> Client Scopes -> Add for all permissions
# clients->client scopes->setup add client scopes to default

# TODO FIXME use client scopes instead of that above

# TODO FIXME keycloak allow user to deny scope

https://www.keycloak.org/app/

# https://lists.jboss.org/pipermail/keycloak-user/2016-September/007621.html
# this may be interesting with realm and client roles?

# https://github.com/keycloak/keycloak-documentation/blob/master/server_admin/topics/clients/client-scopes.adoc
```