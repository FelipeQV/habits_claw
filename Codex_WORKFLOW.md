# Codex Workflow Rules

## Branch policy
- Never work directly on `main`.
- If the current branch is `main`, stop and ask Felipe to create/switch to a feature branch first.
- Only work on feature branches (e.g., `codex/<task-name>`, `kevin_new_flow`).
- Never merge into `main` yourself.
- Never push directly to `main`.

## Approval policy
- Within the agreed task scope you may edit files, create new files, run relevant tests, and iterate without asking for approval on every change.
- Anything outside the agreed scope requires explicit approval before proceeding.

## Out-of-scope examples (need approval)
- Touching unrelated files or areas outside the task.
- Broad architecture changes beyond the approved task.
- Editing deployment, infrastructure, secrets, or auth configuration (`.github`, CI, credentials, etc.).
- Force-pushing, rebasing shared branches, merging, or pushing directly to `main`.

## Merge policy
- When the work is complete, summarize:
  - what changed
  - what risks remain
  - what tests were run
  - what Felipe should review
- Stop and wait for Felipe’s explicit approval before any merge/PR-finalization.

## Git policy
- Work on the current feature branch only.
- Do not merge.
- Do not push to `main`.
- Ask before pushing the feature branch unless the task scope already granted permission.
