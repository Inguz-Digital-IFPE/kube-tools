# kube-tools

Github Action with Kubernetes tools: kubectl, helm, jq, awscli

GitHub Workflow example:

```yaml
name: CI

on: [push, pull_request]

jobs:
  test-action:
    runs-on: ubuntu-latest
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-2

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v1

      - uses: actions/checkout@v2
        name: Run Kubernetes tools
        uses: inguz/kube-tools@v1
        with:
          kubectl: 1.18.4
          helm: 3.3.0
          awscli: 2.0.30
          command: |
            echo "Run conftest"
            echo "Configure Kubernetes"
            aws eks update-kubeconfig --name cluster-eksctl
```
GitHub Workflow example for doctl:

```yaml
name: CI

on: [push, pull_request]

jobs:
  test-action:
    runs-on: ubuntu-latest
    steps:
      - name: Run Kubernetes tools
        uses: inguz/kube-tools@v1
        with:
          TOKEN: ${{secrets.OCEAN_TOKEN}}
          kubectl: 1.18.4
          helm: 3.3.0
          doctl: 1.56.0
          command: |
            echo "Run conftest"
            echo "Login doctl"
            doctl auth init -t $TOKEN
            echo "Configure kubectl"
            doctl kubernetes cluster kubeconfig save use_your_cluster_name
```