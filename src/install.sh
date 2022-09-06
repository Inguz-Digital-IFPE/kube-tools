#!/usr/bin/env bash

set -o errexit

echo "downloading zip"
apt update
apt install -y zip
apt install -y curl

DOCTL_VER=1.56.0
echo "downloading doctl ${DOCTL_VER}"
cd ~
curl -sL https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VER}/doctl-${DOCTL_VER}-linux-amd64.tar.gz | tar -xzv
mv ~/doctl /usr/local/bin
chmod +x /usr/local/bin/doctl

AWSCLI=2.4.0
echo "downloading awscli ${KUBECTL}"
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI}.zip -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

KUBECTL=1.18.2
echo "downloading kubectl ${KUBECTL}"
curl -sL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/linux/amd64/kubectl \
-o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl
kubectl version --client

HELM=3.3.0
echo "downloading helm ${HELM}"
curl -sSL https://get.helm.sh/helm-v${HELM}-linux-amd64.tar.gz | \
tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
helm version

echo "downloading jq"
curl -sL https://github.com/stedolan/jq/releases/latest/download/jq-linux64 \
-o /usr/local/bin/jq && chmod +x /usr/local/bin/jq
jq --version

echo "downloading grep"
apt install -y grep
grep --version