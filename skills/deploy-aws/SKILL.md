---
name: deploy-aws
description: Design and prepare AWS infrastructure for a Spacode project with develop/staging/production — ECS Fargate or App Runner, RDS Postgres, ElastiCache Redis, S3/CloudFront, Secrets Manager, CloudWatch, IaC with Terraform or CDK, GitHub Actions OIDC deploys. Use when the hosting decision is AWS or the user asks about AWS deployment.
---

# Deploy on AWS

Infrastructure as Code only. You write IaC and runbooks; the human applies to staging/production.

## Account & environment strategy
- Preferred: separate AWS accounts (or at least separate VPC/stacks) for dev, staging, prod via AWS Organizations.
- Region: `il-central-1` (Tel Aviv) when data residency or latency matters; otherwise state region in ADR.
- Tags on everything: `client`, `project`, `env`, `owner=spacode`.

## Reference architecture
- **Network:** VPC with public subnets (ALB) and private subnets (tasks, RDS, Redis); NAT (consider cost) or VPC endpoints.
- **Compute:** ECS Fargate services `api`, `worker`, `web` (or `web` on Vercel/Amplify if chosen), images in ECR, autoscaling on CPU/queue depth.
- **Data:** RDS PostgreSQL (Multi-AZ in prod, automated backups + PITR, encryption), ElastiCache Redis.
- **Files:** S3 (private, signed URLs) + CloudFront.
- **Secrets:** Secrets Manager / SSM Parameter Store, injected into task definitions.
- **Edge:** ALB + ACM certificates, Route 53, optional WAF for public apps.
- **Observability:** CloudWatch logs (retention set), alarms (5xx, latency, CPU, RDS storage, queue backlog), Sentry.
- **Cost:** AWS Budgets with alerts per environment.

## CI/CD
- GitHub Actions authenticates with **OIDC** role per environment (no long-lived access keys).
- Build image once, push to ECR with git SHA tag, deploy same image to each environment.
- Migration step: one-off ECS task running `db:migrate:deploy` before updating services.
- Production job uses GitHub Environment `production` with required reviewers.

## Deliverables
- `infra/` Terraform modules (network, ecs-service, rds, redis, s3-cdn) + `envs/{dev,staging,prod}` — or CDK stacks equivalent.
- `docs/runbooks/deploy.md`, `rollback.md` (redeploy previous task definition revision), `aws-access.md` (who has which role).
- Security baseline: no public RDS, least-privilege task roles, CloudTrail on, root MFA, IAM Identity Center for humans.
