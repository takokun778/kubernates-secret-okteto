#!/bin/bash -ue

# https://www.okteto.com/docs/cloud/okteto-cli/#built-in-tools-when-deploying-to-okteto-cloud

uname -a

SOPS_VERSION=3.7.3

apt-get install wget > /dev/null

wget --quiet https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64

mv sops-v${SOPS_VERSION}.linux.amd64 sops

chmod +x sops

./sops --decrypt --in-place tmp/secret/secret.yaml

kubectl apply -f ./k8s
