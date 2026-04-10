---
name: analyze-requirement
description: >
  Use this skill to analyze a requirement document and create a technical implementation plan (SA role).
  When a user says "analyze requirement", "implementation plan from requirement", "design solution for",
  "technical analysis", or references a requirement.md and wants to plan the implementation — activate
  this skill. It reads the requirement, analyzes the related codebase, designs a technical solution,
  and produces implementation-plan.md and task.md files. Use this whenever someone has a documented
  requirement and wants to move from "what" to "how".
tags: [agent, architecture, SA, requirement, system-design]
---

# Analyze Requirement (SA)

This skill guides the agent through analyzing a requirement document and designing
a technical solution, acting as a Solution Architect. It reads the requirement,
studies the existing codebase, and produces an implementation plan with a task checklist.

## Workflow

### 1. Locate the Requirement

When the user asks to analyze a requirement:

1. **Identify which requirement** — the user may specify by:
   - Feature name: `"analyze requirement for user-authentication"`
   - Path: `"analyze docs/feature/payment-gateway/requirement.md"`
   - Reference: `"create implementation plan from requirement 'xxx'"`

2. **Find the file** — look for `requirement.md` at:

   ```
   <project-directory>/docs/feature/<feature-name>/requirement.md
   ```

   If not found, search the project for `requirement.md` files and ask the user which one.

3. **Read and understand** the requirement thoroughly before proceeding.

### 2. Analyze the Existing Codebase

This is the critical SA step — understand the current system before designing changes.

#### 2.1 Architecture Discovery

- Use `view_file_outline` on key files to understand project structure
- Use `list_dir` to map the directory structure
- Identify the tech stack, frameworks, and patterns in use

#### 2.2 Related Code Analysis

- Use `grep_search` to find code related to the requirement's domain
- Use `view_code_item` to read important functions, classes, and modules
- Identify:
  - **Files that need modification**
  - **Patterns to follow** (how similar features were implemented)
  - **Shared utilities** that can be reused
  - **Database models/schemas** that may need changes
  - **API endpoints** that may be affected
  - **Test patterns** used in the project

#### 2.3 Impact Assessment

- What existing functionality might be affected?
- Are there any potential conflicts or breaking changes?
- What dependencies exist between components?

### 3. Design the Technical Solution

Based on the requirement and codebase analysis:

1. **Choose an approach** — if there are multiple viable approaches, present them
   briefly with pros/cons and recommend one. Let the user decide if it's a significant
   architectural choice.

2. **Detail the changes** — for each component/file:
   - What needs to change and why
   - New files to create
   - Files to modify (be specific about what changes)
   - Files to delete (if any)

3. **Consider**:
   - Database migrations needed
   - API contract changes
   - UI/UX implications
   - Error handling strategy
   - Security considerations
   - Performance implications
   - Backward compatibility

### 4. Generate implementation-plan.md

Create the file at:

```
<project-directory>/docs/feature/<feature-name>/implementation-plan.md
```

Use this template:

```markdown
# Implementation Plan: <Feature Name>

> Created: <date>
> Requirement: [requirement.md](./requirement.md)
> Status: Draft

## Requirement Summary

<Brief summary of the requirement — not a copy, a concise restatement>

## Current Architecture Analysis

<What exists today that's relevant to this feature>

### Related Components

- `path/to/file.ext` — <what it does, why it's relevant>
- ...

### Patterns & Conventions

<Patterns observed in the codebase that this implementation should follow>

## Proposed Changes

### <Component/Module 1>

#### [MODIFY] `path/to/existing-file.ext`

- <What to change and why>

#### [NEW] `path/to/new-file.ext`

- <What this file does>

### <Component/Module 2>

...

## Database Changes

<Schema changes, migrations, seed data — or "No database changes required">

## API Changes

<New/modified endpoints, request/response formats — or "No API changes required">

## Verification Plan

### Automated Tests

- <Test 1: what to test and how>
- <Test 2: ...>

### Manual Verification

- <Step 1>
- <Step 2>

## Risks & Mitigations

| Risk     | Impact   | Mitigation   |
| -------- | -------- | ------------ |
| <Risk 1> | <Impact> | <Mitigation> |

## Open Questions

- <Any technical decisions that need further input>
```

### 5. Generate task.md

Create the file at:

```
<project-directory>/docs/feature/<feature-name>/task.md
```

Break down the implementation plan into actionable tasks with this template:

```markdown
# Task: <Feature Name>

> Implementation Plan: [implementation-plan.md](./implementation-plan.md)
> Requirement: [requirement.md](./requirement.md)

## Setup

- [ ] Create feature branch `feature/<feature-name>`
- [ ] <Any setup steps>

## Implementation

- [ ] <Task 1: specific and actionable>
  - [ ] <Sub-task 1.1>
  - [ ] <Sub-task 1.2>
- [ ] <Task 2>
  - [ ] <Sub-task 2.1>
- [ ] ...

## Testing

- [ ] Write unit tests for <component>
- [ ] Write integration tests for <flow>
- [ ] Manual testing

## Review & Deploy

- [ ] Code review
- [ ] Update documentation
- [ ] Deploy to staging
- [ ] Production deployment
```

Task breakdown guidelines:

- Each task should be **completable in ≤ 2 hours**
- Tasks should be **ordered by dependency** (do X before Y)
- Use **verb-first** descriptions: "Add", "Create", "Update", "Fix", "Remove"
- Include **file paths** where relevant for quick reference
- Group by logical component or phase

### 6. Present to the User

After generating both files:

- Show the user the generated file paths
- Highlight any **open questions** or **architectural decisions** that need their input
- Ask if they want to adjust the plan before starting implementation

## Important Guidelines

- **Always read the codebase** — never generate a plan based solely on the requirement without understanding the existing code
- **Be specific** — mention actual file paths, function names, and module names from the codebase
- **Follow existing patterns** — the implementation should feel consistent with the rest of the codebase
- **Don't over-engineer** — propose the simplest solution that meets the requirements
- **Flag risks honestly** — if something is complex or risky, say so
- **Link back to requirements** — each proposed change should trace back to a requirement


## Use this skill when

- The user has a documented requirement (e.g., `requirement.md`) and wants to create a technical implementation plan
- The user says "analyze requirement", "implementation plan from requirement", "design solution for", or "technical analysis"
- The user references a requirement file and wants to move from "what to build" to "how to build it"
- The user needs a Solution Architect (SA) perspective on a feature before coding begins

## Do not use

- When the user is still defining or gathering requirements — use the `clarify-requirements` skill instead
- When the user wants to brainstorm ideas before formalizing — use the `brainstorming` skill instead
- When the user wants to directly write code without a plan
- When the task is a simple bug fix or minor change that doesn't need architectural analysis

## Instructions

1. Locate the requirement document in the project (typically at `docs/feature/<feature-name>/requirement.md`)
2. Read and fully understand the requirement before proceeding
3. Analyze the existing codebase — discover architecture, related code, patterns, and assess impact
4. Design the technical solution with specific file paths, component changes, and migration needs
5. Generate `implementation-plan.md` using the provided template with proposed changes, verification plan, and risks
6. Generate `task.md` with actionable, ordered checklist items (each completable in ≤ 2 hours)
7. Present both files to the user and highlight any open questions or architectural decisions needing input
