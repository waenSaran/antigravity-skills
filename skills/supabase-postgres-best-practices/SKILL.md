---
name: supabase-postgres-best-practices
description: Postgres performance optimization and best practices from Supabase. Use this skill when writing, reviewing, or optimizing Postgres queries, schema designs, or database configurations.
tags: [postgresql, database, sql, supabase, optimization, backend]
license: MIT
metadata:
  author: supabase
  version: "1.1.0"
  organization: Supabase
  date: January 2026
  abstract: Comprehensive Postgres performance optimization guide for developers using Supabase and Postgres. Contains performance rules across 8 categories, prioritized by impact from critical (query performance, connection management) to incremental (advanced features). Each rule includes detailed explanations, incorrect vs. correct SQL examples, query plan analysis, and specific performance metrics to guide automated optimization and code generation.
---


# Supabase Postgres Best Practices

Comprehensive performance optimization guide for Postgres, maintained by Supabase. Contains rules across 8 categories, prioritized by impact to guide automated query optimization and schema design.


## Rule Categories by Priority

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Query Performance | CRITICAL | `query-` |
| 2 | Connection Management | CRITICAL | `conn-` |
| 3 | Security & RLS | CRITICAL | `security-` |
| 4 | Schema Design | HIGH | `schema-` |
| 5 | Concurrency & Locking | MEDIUM-HIGH | `lock-` |
| 6 | Data Access Patterns | MEDIUM | `data-` |
| 7 | Monitoring & Diagnostics | LOW-MEDIUM | `monitor-` |
| 8 | Advanced Features | LOW | `advanced-` |

## How to Use

Read individual rule files for detailed explanations and SQL examples:

```
references/query-missing-indexes.md
references/schema-partial-indexes.md
references/_sections.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect SQL example with explanation
- Correct SQL example with explanation
- Optional EXPLAIN output or metrics
- Additional context and references
- Supabase-specific notes (when applicable)

## References

- https://www.postgresql.org/docs/current/
- https://supabase.com/docs
- https://wiki.postgresql.org/wiki/Performance_Optimization
- https://supabase.com/docs/guides/database/overview
- https://supabase.com/docs/guides/auth/row-level-security


## Use this skill when

- Writing SQL queries, designing schemas, or creating indexes for Postgres databases
- Reviewing or optimizing database performance (slow queries, missing indexes, N+1 patterns)
- Configuring connection pooling, scaling, or Supabase-specific features
- Implementing Row-Level Security (RLS) policies or security best practices
- Working with Supabase projects that use Postgres as the primary database

## Do not use

- For non-Postgres databases (MySQL, MongoDB, DynamoDB) — patterns are database-specific
- For application-level ORM queries where the framework handles SQL generation — unless optimizing the generated SQL
- For frontend or client-side code that doesn't directly interact with the database

## Instructions

1. Identify the relevant rule category from the priority table (Query Performance, Connection Management, Security & RLS, Schema Design, etc.)
2. Read the specific rule file from `references/<prefix>-<rule-name>.md` for detailed SQL examples and EXPLAIN output
3. Apply the correct pattern — each rule shows incorrect SQL, correct SQL, and performance metrics
4. Prioritize CRITICAL rules (Query Performance, Connection Management, Security & RLS) when multiple issues exist
5. For Supabase-specific guidance, check the Supabase-specific notes in each rule file
