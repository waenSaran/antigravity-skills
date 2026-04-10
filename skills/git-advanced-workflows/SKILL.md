---
name: git-advanced-workflows
description: Master advanced Git workflows and automate git operations with ease. Trigger via shortcuts like /commit, /rebase, /cherrypick, /bisect, /worktree, /recover. Use when modifying history, synchronizing complex branches, or recovering mistakes.
---

# Git Advanced Workflows

Master advanced Git techniques and automate operations directly through your AI assistant. Maintain clean history, collaborate effectively, and recover from mistakes with confidence.

## When to Use This Skill
- You want to autonomously format and commit your staged changes (`/commit`).
- Cleaning up commit history before merging (`/rebase`, `/cleanup`).
- Applying specific commits across branches (`/cherrypick`, `/backport`).
- Finding commits that introduced bugs (`/bisect`, `/findbug`).
- Working on multiple features simultaneously in isolated folders (`/worktree`).
- Recovering from Git mistakes or lost commits (`/recover`, `/reflog`).

## Core Concepts (Quick Reference)

1. **Interactive Rebase (`git rebase -i`)**: The Swiss Army knife of Git history editing. Useful for squashing, rewording, and dropping local commits.
2. **Cherry-Picking (`git cherry-pick`)**: Apply specific commits from one branch to another without merging entire branches.
3. **Bisect (`git bisect`)**: Binary search through commit history to find exactly when a bug was introduced.
4. **Worktrees (`git worktree`)**: Work on multiple branches simultaneously in separate directories without stashing.
5. **Reflog (`git reflog`)**: The ultimate safety net that tracks all reference movements, even deleted branches/commits.

*(For detailed bash examples, command parameters, and advanced techniques, see `resources/implementation-playbook.md`)*

---

## Actionable Shortcuts (Agent Checklists)

The framework supports automatically executing comprehensive workflows for you via text shortcuts. When you invoke any of these, follow the respective checklist:

### Workflow 1: Smart Commit (`/commit` or "commit changes")
When triggered, evaluate the current git state and commit the changes according to the standards.
1. Run `git status` to see what is staged/unstaged. Check `git diff` and `git diff --staged`.
2. Extract the ticket/issue ID from the branch name using regex `[A-Z]+-\d+` if one exists (e.g., `feature/CORE-550`).
3. Categorize the change (feat, fix, docs, refactor, chore, etc.) based on the diffs.
4. Generate the commit message following the exact specifications in `resources/commit-format-reference.md`.
5. Display the generated commit message to the user.
6. Run `git add -A` followed by `git commit -m "..."` using the generated message.
7. Stop. Do NOT push to a remote unless explicitly told to.

### Workflow 2: Interactive Rebase (`/rebase` or `/cleanup`)
Help the user clean up their branch before a PR.
1. Confirm the target branch (usually `main`).
2. Propose actions (e.g., squash "fix typo" commits, reword unclear messages).
3. Check `git status`. Ensure the working directory is clean.
4. Execute the interactive rebase, using `--autosquash` if requested.
5. If conflicts occur, pause and guide the user through resolution.
6. Validate post-rebase status with `git log --oneline -5`.

### Workflow 3: Cherry-Pick Hotfix (`/cherrypick` or `/backport`)
Help the user apply a fix to multiple environments.
1. Get the commit hash for the target change.
2. Ask the user for the target branch(es) (e.g., `release/v2.1`).
3. Check out the target branch.
4. Run `git cherry-pick <hash>`.
5. Pause for the user to resolve conflicts, or proceed if clean.
6. Switch back to the original branch when complete.

### Workflow 4: Automated Bisect (`/bisect` or `/findbug`)
Assist with finding a bug introduction via binary search.
1. Identify a known "good" commit and a known "bad" commit.
2. Initiate `git bisect start`, `git bisect bad <bad-commit>`, `git bisect good <good-commit>`.
3. Inform the user what commit was checked out.
4. If testing is manual, wait for the user to run their tests and report "good" or "bad", then execute `git bisect good` or `bad`.
5. Repeat step 4 until the offending commit is isolated.
6. Run `git bisect reset` when complete.

### Workflow 5: Worktree Sandbox (`/worktree`)
Spin up a safe environment for a hotfix while keeping the current branch state frozen.
1. Ask the user for the worktree name and branch type (e.g., `hotfix/urgent-issue`).
2. Run `git worktree add ../<folder-name> <branch-name>`.
3. Provide instructions on routing development into that new folder.
4. Provide instructions on `git worktree remove` when done.

### Workflow 6: Mistake Recovery (`/recover` or `/reflog`)
Recover a lost branch, commit, or undo a bad reset.
1. Run `git reflog -n 20` to show recent history.
2. Analyze the output to identify the likely pre-mistake state.
3. Propose a recovery command (e.g., `git reset --hard HEAD@{2}` or `git branch recovered-branch <hash>`).
4. Execute upon confirmation.

---

## Best Practices & Safety

- **Always Use `--force-with-lease`**: When pushing after a rebase, this is safer than `--force`, preventing overwriting others' work.
- **Rebase Only Local Commits**: Use caution when rebasing commits that have already been pushed and shared.
- **Keep Reflog Aware**: Reflog is your safety net, but it expires after 90 days.
- **Branch Before Risky Operations**: Always recommend the user creates a backup branch before complex rebases.

## Recovery Commands
- Abort operations: `git rebase --abort`, `git cherry-pick --abort`, `git merge --abort`
- Restore file from specific commit: `git restore --source=<hash> <file>`
- Undo last commit but keep changes: `git reset --soft HEAD^`
- Undo last commit and discard changes: `git reset --hard HEAD^`

---

## Resources
- **Reference**: [`resources/implementation-playbook.md`](file:///Users/saranya/Desktop/private-repos/antigravity-skills/skills/git-advanced-workflows/resources/implementation-playbook.md) (All detailed command syntaxes and examples)
- **Reference**: [`resources/commit-format-reference.md`](file:///Users/saranya/Desktop/private-repos/antigravity-skills/skills/git-advanced-workflows/resources/commit-format-reference.md) (Format checks for Smart Commit)
