---
name: dependency-vetting
description: Vet a package, framework, runtime or Docker image and choose a safe version before adding or upgrading it — maintenance, license, known vulnerabilities (OSV, npm/pnpm audit, pip-audit, trivy), latest stable without high/critical CVEs — and record the decision. Use whenever adding a dependency, starting a project, upgrading framework versions, or asked "איזו גרסה", "is this package safe".
---

# Dependency Vetting

Read `.cursor/rules/13-dependencies-supply-chain.mdc`. Use real lookups — never state versions or vulnerability status from memory.

## For each candidate
1. **Necessity:** can we do without it / with an existing dependency?
2. **Health:** last release date, release cadence, open security issues, maintainers, weekly downloads, repository activity.
3. **License:** commercial-friendly? (flag GPL/AGPL/unknown).
4. **Versions:** `npm view <pkg> version versions --json` · `pip index versions <pkg>` · Docker Hub tags / `docker manifest inspect`.
5. **Vulnerabilities for the exact version:**
   - `osv-scanner --lockfile=<lockfile>` (or query OSV/GitHub advisories for `<pkg>@<version>`)
   - `pnpm audit --prod` / `npm audit` after installing in a work branch
   - `pip-audit` for Python
   - `trivy image <image:tag>` for base images
6. **Choose:** latest stable with no known high/critical vulnerability; for frameworks prefer versions in active support (Node LTS, Next.js current major, Expo SDK accepted by `expo-doctor`).
7. **Install** with the ecosystem's tool (`pnpm add`, `npx expo install`, `uv add`), commit lockfile.

## Report (table in the PR or ADR)
| Package | Chosen version | Latest | Why this version | Vulns found | License | Notes |

If something has no safe version, say so and propose an alternative or a mitigation — don't silently pick a vulnerable one.
