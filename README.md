# EKS-Terraform-Multi-Environment

This repository provisions an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform. It is structured for multi-environment support (e.g., `dev`, `stage`, `prod`) using **Terraform workspaces**, **remote state with S3**, and **DynamoDB state locking**. It also includes optional Prometheus monitoring via Helm.

---

## Features

- Modular Terraform codebase (`/modules`)
- Multi-environment support using [Terraform Workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces)
- AWS S3 remote state backend with DynamoDB locking
- Infrastructure includes:
  - VPC
  - IAM roles (for EKS cluster & node group)
  - EKS cluster
  - Managed node group
  - Optional Prometheus stack via Helm

---

## Project Structure

```bash
.
├── main.tf                    # Root config using modules
├── variables.tf
├── outputs.tf
├── backend.tf                # Shared remote backend config
├── modules/
│   ├── vpc/
│   ├── eks_cluster/
│   ├── eks_node_group/
│   ├── iam-role-cluster/
│   ├── iam-role-node-group/
│   ├── remote_state/
│   └── monitoring/
│       └── prometheus/
└── .github/
    └── workflows/
        └── terraform-plan.yaml
```

---

##  Getting Started

### 1. Bootstrap remote state infrastructure

Before provisioning EKS, create the S3 bucket and DynamoDB table used for remote state:

```bash
cd bootstrap/
terraform init
terraform apply
```

---

### 2. Configure Terraform backend

Update `backend.tf` with your values (already configured in this repo):

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-eks-state-lance"
    key            = "terraform/dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-eks-state-lance-locks"
  }
}
```

---

### 3. Select or create a Terraform workspace

```bash
terraform workspace new dev
terraform workspace select dev
```

---

### 4. Initialize and plan

```bash
terraform init
terraform plan -var-file="dev.tfvars"
```

This repo is configured to **not run `terraform apply`** in CI to avoid incurring AWS charges.

---

##  GitHub Actions

This repo includes a CI workflow that runs `terraform plan` on push to `main` or PRs:

```yaml
.github/workflows/terraform-plan.yaml
```

You must set the following **GitHub secrets**:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `TF_WORKSPACE` (e.g. `dev`)

---

## Monitoring with Prometheus

The project includes a module to deploy Prometheus with Grafana using Helm:

```bash
module "prometheus" {
  source = "./modules/monitoring/prometheus"
}
```

### Configuration:
- Namespace: `monitoring`
- Helm Chart: `kube-prometheus-stack`
- Source: [prometheus-community/helm-charts](https://github.com/prometheus-community/helm-charts)
- Grafana is exposed via LoadBalancer and uses `admin/prom-operator` by default.

---

## Useful Commands

```bash
terraform workspace new stage
terraform workspace select stage
aws dynamodb scan --table-name terraform-eks-state-lance-locks --region eu-west-1 --output table
terraform force-unlock <LOCK_ID>
```

---

## Resources

- [Terraform EKS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [Helm Terraform Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)

---
