# Commit Format Reference

When the `/commit` workflow is triggered, the generated commit message MUST follow the specifications defined in this document.

## Detection Rules
1. **Ticket ID Extraction**: The agent should attempt to extract the Ticket/Issue ID from the current branch name using regex validation (e.g., `[A-Z]+-\d+`).
   - If a branch is named `feature/EXAMPLE-123-add-login`, the ID is `EXAMPLE-123`.
   - If no valid ticket is found, the agent proceeds without the ticket prefix.

## Required Commit Format
The commit format strictly adheres to the standard Conventional Commits format, heavily favoring clarity.

```
<type>(<ticket-id>): <short description>

- bullet list showing specifically what was changed
- second item (optional)
```

**Example with ticket:**
```
feat(EXAMPLE-123): implement user login form

- added email and password input fields
- integrated form with authentication service API
```

**Example without ticket:**
```
fix: resolve null pointer in payment gateway

- added missing null check around user metadata object
```

## Authorized Categories (Types)
- **feat**: A new feature (correlates with MINOR in semver)
- **fix**: A bug fix (correlates with PATCH in semver)
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies (example scopes: npm, docker)
- **ci**: Changes to CI configuration files and scripts (example scopes: github actions, gitlab runner)
- **chore**: Other changes that don't modify src or test files
- **revert**: Reverts a previous commit

## Guidelines
- Ensure the short description (the subject line) is in the **imperative mood** (e.g., "add", not "added" or "adds").
- Ensure the short description is no longer than **50 characters**.
- For simple or one-line changes, the bulleted list in the body can be omitted.
