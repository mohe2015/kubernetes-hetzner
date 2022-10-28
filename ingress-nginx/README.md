https://kubernetes.github.io/ingress-nginx/

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace -f ingress-nginx/values.yaml


export HTTP_NODE_PORT=$(kubectl --namespace ingress-nginx get services -o jsonpath="{.spec.ports[0].nodePort}" ingress-nginx-controller)
export HTTPS_NODE_PORT=$(kubectl --namespace ingress-nginx get services -o jsonpath="{.spec.ports[1].nodePort}" ingress-nginx-controller)
export NODE_IP=$(kubectl --namespace ingress-nginx get nodes -o jsonpath="{.items[0].status.addresses[1].address}")

  echo "Visit http://$NODE_IP:$HTTP_NODE_PORT to access your application via HTTP."
  echo "Visit https://$NODE_IP:$HTTPS_NODE_PORT to access your application via HTTPS."

# https://[2a01:4f8:1c1e:4f60::1]:31849/




kubectl get pods --namespace=ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s


kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo
kubectl create ingress demo-localhost --class=nginx \
  --rule="demo.localdev.me/*=demo:80"

kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80