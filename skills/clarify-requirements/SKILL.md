---
name: clarify-requirements
description: >
  Use this skill to gather, clarify, and document software requirements (BA role).
  When a user mentions a new feature, requirement, user story, or says things like
  "I need a feature for...", "let's define requirements for...", "gather requirements",
  or describes a business need — activate this skill. It interviews the user systematically,
  ensures all aspects are covered, and produces a structured requirement.md document.
  Use this even if the user doesn't explicitly say "requirements" — if they're describing
  what they want built, this skill helps formalize it before jumping into code.
tags: [agent, BA, requirement, user-story, planning]
---

# Clarify Requirements (BA)

This skill guides the agent through a structured requirements gathering process,
acting as a Business Analyst. The goal is to interview the user until the requirement
is clear and complete, then produce a well-structured `requirement.md`.

## Workflow

### 1. Identify the Feature

Ask the user for:

- **Feature name** (will be used as directory name, use kebab-case)
- **Brief description** — what problem does this solve?

If the user already described the feature in conversation, extract these from context
and confirm with the user.

### 2. Gather Requirements — Interview Checklist

Go through each category below. Ask questions conversationally — don't dump all
questions at once. Ask 2-3 at a time, wait for answers, then follow up.

#### Background & Context

- What is the business problem or need?
- Who requested this? What triggered this requirement?
- Is there an existing solution? What's wrong with it?

#### Users & Stakeholders

- Who are the target users? (roles, personas)
- Who are the stakeholders?
- How many users are expected?

#### Functional Requirements

- What should the system do? (user stories format: "As a [role], I want [action], so that [benefit]")
- What are the main workflows/user flows?
- What inputs and outputs are expected?
- What are the business rules and validations?

#### Non-Functional Requirements

- Performance expectations (response time, throughput)
- Security requirements (authentication, authorization, data sensitivity)
- Scalability needs
- Compatibility/integration requirements

#### Acceptance Criteria

- How do we know this is "done"?
- What are the specific testable conditions?
- Are there any edge cases to handle?

#### Dependencies & Constraints

- Any dependencies on other systems/features?
- Technical constraints (specific tech stack, legacy systems)?
- Timeline or budget constraints?
- Regulatory/compliance requirements?

#### Out of Scope

- What is explicitly NOT part of this feature?
- Any related features planned for later?

### 3. Clarify & Follow Up

After the initial gathering:

- Identify any **gaps or ambiguities** in the information
- Ask targeted follow-up questions
- **Do NOT assume or fill in gaps yourself** — always ask the user
- Continue until you're confident the requirement is complete

### 4. Summarize & Confirm

Before generating the file:

- Present a **summary** of all gathered requirements to the user
- Ask: "Does this look complete and accurate? Anything to add or change?"
- Only proceed to file generation after user confirms

### 5. Generate requirement.md

Determine the project root directory from the user's workspace context.

Create the file at:

```
<project-directory>/docs/feature/<feature-name>/requirement.md
```

Use this template:

```markdown
# Feature: <Feature Name>

> Created: <date>
> Status: Draft

## Background / Context

<Business context, problem statement, what triggered this requirement>

## User Stories / Use Cases

- As a [role], I want [action], so that [benefit]
- ...

## Functional Requirements

### FR-1: <Title>

<Description>

### FR-2: <Title>

<Description>

## Non-Functional Requirements

### Performance

<Performance expectations>

### Security

<Security requirements>

### Scalability

<Scalability needs>

## Acceptance Criteria

- [ ] <Testable condition 1>
- [ ] <Testable condition 2>
- ...

## Out of Scope

- <Item 1>
- <Item 2>

## Open Questions

- <Any remaining questions or items needing further clarification>

## Dependencies

- <Dependency 1>
- <Dependency 2>

## Constraints

- <Constraint 1>
- <Constraint 2>
```

### 6. Inform the User

After generating the file, tell the user:

- The path to the generated file
- Remind them they can ask to "analyze" or "create implementation plan" for this requirement to proceed to the SA phase
- Ask if they want to review or edit anything

## Important Guidelines

- **Never skip the interview** — even if the user provides a wall of text, confirm each category
- **Be conversational** — don't be robotic; adapt your questions based on answers
- **Use the user's language** — if they describe things in Thai, write the requirement in Thai (but keep headings in English for structure)
- **kebab-case for feature names** — e.g., `user-authentication`, `payment-gateway`
- **Don't generate code** — this skill is purely about documenting requirements


## Use this skill when

- The user mentions a new feature, requirement, or user story that needs formalization
- The user says "I need a feature for...", "let's define requirements for...", "gather requirements", or describes a business need
- The user is describing what they want built but hasn't documented it yet — even if they don't say "requirements"
- The team needs a structured `requirement.md` before moving to technical implementation

## Do not use

- When the user already has a documented `requirement.md` and wants to create an implementation plan — use `analyze-requirement` instead
- When the user wants to brainstorm ideas or explore approaches — use `brainstorming` instead
- When the user wants to write code directly — requirements must be formalized first
- When the task is a bug fix or minor enhancement with clear scope that doesn't need formal documentation

## Instructions

1. Identify the feature name (kebab-case) and get a brief description of the problem it solves
2. Interview the user systematically across all categories: background/context, users/stakeholders, functional requirements, non-functional requirements, acceptance criteria, dependencies/constraints, and out-of-scope items
3. Ask 2-3 questions at a time conversationally — never dump all questions at once
4. Identify gaps or ambiguities and ask targeted follow-up questions — never assume or fill in gaps yourself
5. Present a summary of all gathered requirements and confirm with the user before proceeding
6. Generate `requirement.md` at `<project-directory>/docs/feature/<feature-name>/requirement.md` using the provided template
7. Inform the user of the file path and remind them they can proceed to the SA phase with `analyze-requirement`
