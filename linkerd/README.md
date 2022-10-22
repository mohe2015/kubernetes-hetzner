https://linkerd.io/2.12/getting-started/

# TODO switch to helm https://linkerd.io/2.12/tasks/install-helm/

curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh
export PATH=$PATH:/root/.linkerd2/bin

linkerd check --pre
linkerd install-cni | kubectl apply -f -
linkerd install --linkerd-cni-enabled | kubectl apply -f -
linkerd check # run this on the server
linkerd dashboard