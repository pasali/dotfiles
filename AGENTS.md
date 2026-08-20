# Global rules

- Never use the em dash "—". Use plain dash "-" instead
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.

## Verification

- Run the project's own checks — its linter, formatter, type checker, tests —
  not ad-hoc substitutes. Find them in the Makefile / package.json /
  pyproject.toml rather than assuming.
- Run the narrowest relevant tests first, then the broader suite before
  reporting done.
- Never disable a lint rule, skip a test, loosen a type, or add
  `--no-verify` to make a check pass. If a check is genuinely wrong, say so
  and let the user decide.
- No sleeps or retries to paper over a race.

## Secrets and destructive actions

- Never print, log, or commit credentials, tokens, keys, or `.env` contents.
- Never hardcode a machine-specific absolute path. Use `$HOME`, config, or
  environment.
- Ask first for anything destructive or hard to undo: `rm -rf`, dropping or
  migrating data, `git push`, force-push, amending a pushed commit, rebasing
  shared history, `git checkout`/`reset` over uncommitted work, rewriting
  files you have not read.
- Do not touch production or infrastructure config as a side effect of
  another task.

## Git

- Commit subject: imperative mood ("Add", "Fix", "Remove" - never "Added"
  or "Adds"), first word capitalized, no trailing period, at most 72 chars.
  Join two related changes with "and"; more than two means the commit is too
  big - split it.
- No conventional-commit prefixes (`feat:`, `fix:`, `chore:`).
- If the task or branch references a ticket (e.g. INF-1234), prefix the
  subject with it: `INF-1234: Add retry to webhook client`.
- Body only when the why is not obvious from the subject: short prose
  wrapped at 72 columns explaining the reason and what was broken before,
  not a list of what changed - the diff shows what changed.
- Examples of the shape:
  `Add curl wrapper that resolves the PUBLIC IP`
  `Fix Homebrew paths for Apple Silicon and speed up zsh startup`
  `INF-2428: Reword clone step to use shallow single-branch clones`
- One logical change per commit. Do not bundle unrelated cleanups.
- No emoji, no `Co-Authored-By`, no tool attribution, no "Generated with"
  trailers, no advertising the model.
- Never commit unless asked. Never push unless asked.
- Check `git status` and `git diff` before committing so you know what you
  are including; do not `git add -A` blindly.

## Retry budget

- Same command failing the same way twice means the environment is the
  problem, not the attempt. Stop, diagnose the blocker, tell the user.
- Do not loop on a tool that returns empty or malformed output. Retry once
  with a correction, then escalate with the raw output.

## Communication

- Lead with the answer. No preamble, no restating the question.
- Concise over comprehensive. Skip summaries of code the user can read in
  the diff.
- Surface tradeoffs and risks you noticed, briefly, once.
- Disagree when the user is wrong about a technical fact, and say why.
  Do not agree reflexively.