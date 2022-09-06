#!/usr/bin/env bash

set -e
set -o pipefail

KUBECTL_VER=$2
if [[ "${KUBECTL_VER}" != "" ]]; then
  curl -sL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl \
  -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl
fi

HELM_VER=$3
if [[ "${HELM_VER}" != "" ]]; then
  curl -sL https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz | \
  tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
fi

AWSCLI=$4
if [[ "${AWSCLI}" != "" ]]; then
  apt install -y zip
  curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI}.zip -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install
fi

echo ">>> Executing command <<<"
echo ""
echo ""

bash -c "set -e;  set -o pipefail; $1"
