use contour for now.

https://github.com/emissary-ingress/emissary

https://www.getambassador.io/docs/emissary/latest/topics/install

https://www.getambassador.io/docs/emissary/latest/topics/install/yaml-install/

https://www.getambassador.io/docs/emissary/latest/topics/install/install-ambassador-oss/

kubectl apply -f https://www.getambassador.io/yaml/ambassador/ambassador-crds.yaml
kubectl apply -f https://www.getambassador.io/yaml/ambassador/ambassador-rbac.yaml

kubectl apply -f ambassador-service.yaml