# Instructions for AI agents (Cursor, Claude Code): install the Spacode AI Kit into the current project

You were given this repository's URL and asked to set up the Spacode rules and skills in the user's
current project. Follow these steps exactly. Do not recreate the files by hand from memory. Always copy
them from the kit, so the project gets the exact versions.

## Steps
1. **Confirm the target:** the target is the root of the currently open project (the workspace folder).
   If it is not a git repository yet, ask the user whether to run `git init` there.
2. **Ask once** (one message, use defaults if the user doesn't care):
   - Project name (default: folder name)
   - Client name (optional)
   - GitHub owner/username (for CODEOWNERS, optional)
   - Does the project include an Expo mobile app? (yes → `--mobile`)
   - Hosting: Railway (default) or AWS? (→ `--hosting railway|aws`)
3. **Get the kit** into a temporary folder **outside** the project. The repo may be private, so use the
   user's existing GitHub authentication:
   ```bash
   KIT_TMP="$(mktemp -d)"
   gh repo clone <OWNER>/spacode-ai-kit "$KIT_TMP/kit" -- --depth 1 \
     || git clone --depth 1 <REPO_URL> "$KIT_TMP/kit"
   ```
   If both fail with an authentication error, stop and tell the user to run `gh auth login` (or set up Git
   credentials). Do not ask for tokens in chat.
4. **Run the installer** from the kit against the project root:
   ```bash
   bash "$KIT_TMP/kit/scripts/install-spacode-kit.sh" "<PROJECT_ROOT>" \
     --name "<name>" [--client "<client>"] [--owner "<github-user>"] [--hosting railway|aws] [--mobile]
   ```
   - Never pass `--force` unless the user explicitly asks to overwrite existing project files.
   - Rules (`.cursor/rules`) and skills (`.cursor/skills`, `.claude/skills`) are always refreshed. That is expected.
5. **Clean up:** `rm -rf "$KIT_TMP"`. Never leave the kit's own `.git` inside the project.
6. **Report** to the user in Hebrew:
   - Which kit version was installed (`.cursor/.spacode-kit-version`)
   - How many rules and skills were installed, and which files were skipped because they already existed
   - The installer's "Next steps" list, especially: fill the AGENTS.md placeholders, set `STITCH_API_KEY` in the OS
     environment and check Cursor Settings → MCP, then run `scripts/setup-github.sh <owner/repo> --hosting <railway|aws>` **from the kit**
     to create the branches, required checks and environments (this needs `gh` with admin rights; ask before running it).
7. **Do not commit or push** unless the user asks. If asked, commit with
   `chore: apply spacode ai kit v<version>` on the current branch.
8. Suggest the next step: "run the project-kickoff skill".

## Updating an existing project to a newer kit version
Same steps. Rules and skills are replaced with the new versions. Project files (AGENTS.md, docs, workflows) are
kept. Show the user `git diff --stat` so they can review the changes.

## Requirements
`git`, `bash` (macOS/Linux; on Windows use Git Bash or WSL), and optionally `gh` (GitHub CLI) for private repos
and for `setup-github.sh`.
