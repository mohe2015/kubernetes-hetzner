https://gateway.envoyproxy.io/v0.3.0/user/quickstart.html
https://gateway-api.sigs.k8s.io/implementations/

```bash
kubectl apply -f https://github.com/envoyproxy/gateway/releases/download/v0.3.0/install.yaml
kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available
kubectl wait --timeout=5m -n gateway-system deployment/gateway-api-admission-server --for=condition=Available
kubectl get all --all-namespaces
kubectl apply -f envoy-gateway/gateway.yaml

# with no routes configured nothing will happen
```