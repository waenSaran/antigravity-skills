# Git Advanced Workflows

> An AI-powered skill that automates complex Git operations through simple shortcut commands.

Instead of memorizing long Git commands, just tell your AI assistant what you need using natural language or shortcut triggers. The agent handles staging, committing, rebasing, cherry-picking, bisecting, and recovery — all following best practices automatically.

## Quick Start

Simply type any of these shortcuts in your AI chat:

| Shortcut | Aliases | What It Does |
|---|---|---|
| `/commit` | "commit", "commit changes" | Stages all changes, auto-detects ticket ID from branch, generates a Conventional Commits message, and commits |
| `/rebase` | `/cleanup` | Interactively cleans up your branch history (squash, reword, drop) before a PR |
| `/cherrypick` | `/backport` | Safely applies a specific commit to one or more target branches |
| `/bisect` | `/findbug` | Binary-searches your commit history to find exactly which commit introduced a bug |
| `/worktree` | — | Creates an isolated working directory for hotfixes without interrupting your current work |
| `/recover` | `/reflog` | Recovers lost commits, deleted branches, or undoes accidental resets |

## Commit Format

The `/commit` shortcut generates messages following [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<ticket-id>): <short description>

- what changed (optional bullet list)
```

**Example:**
```
feat(CORE-550): add user authentication flow

- implemented JWT token generation
- added login and logout endpoints
```

### Supported Types

| Type | When to Use |
|---|---|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation changes only |
| `style` | Formatting, whitespace (no logic change) |
| `refactor` | Code restructuring (no new feature, no bug fix) |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `build` | Build system or dependency changes |
| `ci` | CI/CD configuration changes |
| `chore` | Maintenance tasks |
| `revert` | Reverting a previous commit |

### Ticket ID Detection

The agent automatically extracts the ticket ID from your branch name using the pattern `[A-Z]+-\d+`:

| Branch Name | Extracted Ticket |
|---|---|
| `feature/CORE-550-auth` | `CORE-550` |
| `hotfix/BUG-42` | `BUG-42` |
| `main` | *(none — ticket prefix omitted)* |

## Usage Examples

### Committing Changes
```
You: /commit
Agent: ✅ Committed: feat(CORE-550): implement login form
       (not pushed to remote)
```

### Cleaning Up Before a PR
```
You: /rebase against main
Agent: Found 8 commits. Proposing to squash 3 "fix typo" commits...
```

### Backporting a Hotfix
```
You: /backport abc1234 to release/v2.1
Agent: Cherry-picked abc1234 onto release/v2.1. No conflicts.
```

### Finding a Bug
```
You: /bisect — last known good commit was v2.0.0
Agent: Checked out commit halfway between v2.0.0 and HEAD.
       Please test and tell me: "good" or "bad"
```

### Emergency Hotfix Without Losing Work
```
You: /worktree for hotfix/payment-crash
Agent: Created worktree at ../project-hotfix on branch hotfix/payment-crash
```

### Recovering Lost Commits
```
You: I accidentally ran git reset --hard! /recover
Agent: Found your lost commits in reflog. Restoring to HEAD@{2}...
```

## File Structure

```
git-advanced-workflows/
├── SKILL.md                                # Agent instructions & shortcut checklists
├── README.md                               # This file
└── resources/
    ├── implementation-playbook.md           # Detailed bash command reference
    └── commit-format-reference.md           # Conventional Commits specification
```

## Notes

- `/commit` will **never** push to remote automatically. You must explicitly ask or run `git push` yourself.
- All shortcuts are designed to pause and ask for confirmation before destructive operations (force push, hard reset, etc.).
- The agent reads `resources/` files on-demand for detailed command syntax — you don't need to read them yourself.
