# ERD — {{PROJECT_NAME}}

**Tenancy model:** shared database, `tenant_id` column on every tenant-owned table (see ADR-0001).
**Updated:** <yyyy-mm-dd>

```mermaid
erDiagram
  TENANTS ||--o{ MEMBERSHIPS : has
  USERS   ||--o{ MEMBERSHIPS : has
  TENANTS ||--o{ AUDIT_LOGS : records
  TENANTS {
    uuid id PK
    text name
    text slug
    timestamptz created_at
  }
  USERS {
    uuid id PK
    citext email
    text password_hash
    timestamptz created_at
  }
  MEMBERSHIPS {
    uuid id PK
    uuid tenant_id FK
    uuid user_id FK
    text role
  }
  AUDIT_LOGS {
    uuid id PK
    uuid tenant_id FK
    uuid actor_user_id
    text action
    jsonb meta
    timestamptz created_at
  }
```

## Entities

### tenants (platform)
| column | type | null | default | notes |
|---|---|---|---|---|
| id | uuid | no | generated | PK |
| name | text | no | | |
| slug | text | no | | unique |
| created_at | timestamptz | no | now() | |
| updated_at | timestamptz | no | now() | |

<!-- Copy this block per entity. Mark (tenant-owned) and (PII) in the heading. List indexes below each table. -->
