https://www.jaegertracing.io/docs/1.43/operator/#understanding-operators

kubectl create namespace observability # <1>
kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.42.0/jaeger-operator.yaml -n observability # <2>
kubectl get deployment jaeger-operator -n observability

kubectl apply -f jaeger/simplest.yaml

kubectl get jaegers

