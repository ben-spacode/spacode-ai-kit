# Test Plan — {{PROJECT_NAME}}

## Critical journeys (from PRD)
| # | Journey | E2E spec | Smoke |
|---|---|---|---|

## Risk areas
## Levels
| Level | When | Contents |
|---|---|---|
| Partial | PR → develop | lint, typecheck, unit, build, secrets, audit |
| Full | develop / staging / PR to staging & main | + integration, contract, E2E (5 browsers/devices), axe, visual, Lighthouse, k6 smoke, ZAP, CodeQL, OSV |
| Release | PR staging → main | + k6 load at peak, UAT, security review |
| Post-deploy | production | @smoke |

## Non-functional targets
p95 < 500ms at <peak> users · error rate < 1% · Lighthouse ≥ 90 ×4 · zero serious axe violations · no high ZAP alerts · no high/critical vulns

## Test data strategy
## Entry / exit criteria per gate
## Mobile (if any): Maestro flows, devices
