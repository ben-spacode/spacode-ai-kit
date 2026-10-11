---
name: deploy-aws
description: Set up and operate a Spacode project on AWS, deployed only through GitHub — Terraform IaC for development/staging/production, one ECS Fargate service per component (web, landing, engine, worker, agents), RDS PostgreSQL, ElastiCache Redis, ECR, ALB, Secrets Manager, GitHub OIDC roles, the AWS mode of pipeline.yml, infra-aws.yml plan/apply, monitoring, costs and rollback. Use when ADR-0001 chose AWS, the client has its own AWS account, or for any AWS deployment question.
---

# Deploy on AWS (via GitHub)

Read `.cursor/rules/09-deployment-infra.mdc`. Verify AWS/Terraform provider details against current docs. You write
IaC, workflows and runbooks; the human approves `apply` for staging/production through GitHub.

## 1. Accounts & state
- Preferred: separate AWS accounts for dev / staging / prod (AWS Organizations); minimum: separate VPCs + stacks in one account.
- Region per ADR (`il-central-1` for Israeli data residency/latency). Check that every service you plan to use is available in that region.
- Terraform remote state: S3 bucket with versioning + encryption, state locking (S3 native lockfile or DynamoDB, per the provider/Terraform version you vetted).

## 2. IaC layout (`infra/`)
```
infra/
  modules/  network · ecr · ecs-cluster · ecs-service · alb · rds · redis · s3-cdn · secrets · github-oidc · monitoring
  envs/     development/ · staging/ · production/   (main.tf, variables, terraform.tfvars without secrets)
```
Per environment:
- VPC: public subnets (ALB), private subnets (ECS, RDS, Redis); NAT or VPC endpoints (mind the cost).
- ECR repos `<repo-prefix>-web|engine|agents|landing`.
- ECS cluster + one Fargate service per component, named `<prefix>-<svc>`, container name `<svc>`; `worker` uses the engine image with the worker command.
- Deployment circuit breaker with rollback, health checks, autoscaling (CPU / request count / queue depth for worker).
- ALB + ACM certificates + Route 53 records (`dev.` / `staging.` / apex / `api.`); optional WAF.
- RDS PostgreSQL (encrypted, automated backups + PITR, Multi-AZ in production, not publicly accessible); ElastiCache Redis/Valkey with TLS.
- Secrets Manager / SSM parameters → injected into task definitions; app config through env vars.
- CloudWatch log groups with retention, alarms (5xx, p95 latency, CPU/memory, RDS storage/connections, queue backlog), AWS Budgets.
- **GitHub OIDC:** IAM OIDC provider + one role per environment, trust policy limited to this repo **and** that GitHub Environment
  (`repo:<owner>/<repo>:environment:<env>`), permissions limited to ECR push, ECS register/update/run-task/describe, `iam:PassRole` for the task roles.

## 3. GitHub configuration (per GitHub Environment)
Variables: `HOSTING=aws`, `AWS_REGION`, `AWS_ROLE_ARN`, `ECS_CLUSTER`, `ECS_SERVICE_PREFIX`, `ECS_SERVICES` (e.g. `web engine worker agents`),
`ECR_REPO_PREFIX`, `ECS_MIGRATION_SERVICE` (e.g. `engine`), `MIGRATION_COMMAND` (JSON array, e.g. `["pnpm","db:migrate:deploy"]`),
`WEB_URL`, `API_URL`. No AWS access keys anywhere.

## 4. Pipelines
- **App deploys:** `.github/workflows/pipeline.yml` (AWS mode) — verify → build/push images (skips tags that exist) → migration task →
  new task-definition revisions → update services → wait stable → `/version.json` check → post-deploy full tests.
- **Infra changes:** `.github/workflows/infra-aws.yml` — `terraform fmt/validate/plan` on PRs that touch `infra/`; `apply` after merge for the
  environment that matches the branch (`develop` → development, `staging` → staging, `main` → production with approval).
  Also run `tflint`/`checkov` (or `trivy config`) on IaC in the plan job.

## 5. Deliverables
`docs/runbooks/deploy.md` (environment × service table, URLs, variable names only), `docs/runbooks/rollback.md`,
`docs/runbooks/aws-access.md` (who has which role; IAM Identity Center for humans; root MFA; CloudTrail on).

## 6. Rollback
Revert the merge on GitHub (preferred). Emergency: `update-service` to the previous task-definition revision (circuit breaker does
this automatically for failed deploys), then reconcile Git the same day. Never roll back DB changes by hand — follow the migration's rollback notes.

## Forbidden
Console or CLI changes to staging/production resources, `terraform apply` from a laptop on staging/production, long-lived access keys,
public RDS/Redis, secrets in tfvars or task definitions as plain text.
