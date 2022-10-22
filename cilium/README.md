# https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/
https://github.com/cilium/cilium

https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/

helm repo add cilium https://helm.cilium.io/
API_SERVER_IP=control-plane.selfmade4u.de
API_SERVER_PORT=6443

helm show values cilium/cilium | grep --color -B 50 "replicas: 2"

helm install cilium cilium/cilium --version 1.12.3 \
    --namespace kube-system \
    --set operator.replicas=1 \
    --set kubeProxyReplacement=strict \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT}

# upgrade example
helm upgrade cilium cilium/cilium --version 1.12.3 \
    --namespace kube-system \
    --set operator.replicas=1 \
    --set kubeProxyReplacement=strict \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT}

kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,HOSTNETWORK:.spec.hostNetwork --no-headers=true | grep '<none>' | awk '{print "-n "$1" "$2}' | xargs -L 1 -r kubectl delete pod

CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

cilium status
cilium connectivity test

# https://docs.cilium.io/en/stable/gettingstarted/hubble_setup/

# TODO FIXME switch to help chart completely which should be possible
cilium hubble disable
cilium hubble enable --ui


export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
HUBBLE_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}


cilium hubble port-forward
hubble status
hubble observe

https://localhost:4245


cilium hubble ui

TODO https://docs.cilium.io/en/stable/gettingstarted/servicemesh/l7-traffic-management/