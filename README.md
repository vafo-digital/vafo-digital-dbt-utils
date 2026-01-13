# vafo digital dbt utils 

Shared **dbt macros and adapter overrides**.

This repository is intentionally **macros-only** and is designed to be consumed as a dbt package via `packages.yml`.

---
<summary><b>Table of Contents</b></summary>

- [vafo digital dbt utils](#vafo-digital-dbt-utils)
  - [Purpose](#purpose)
  - [Repository Structure](#repository-structure)
  - [Usage](#usage)
  - [Conventions](#conventions)


## Purpose

This package provides:

- Reusable dbt macros
- Standard hooks (audit / metadata)
- Incremental & backfill helpers
- Hashing & surrogate key utilities
- Adapter-specific overrides (Snowflake)

The goal is to **centralise common dbt logic**, reduce duplication, and enforce consistent patterns across projects.

---

## Repository Structure

```
macros/
├── hooks/          # lifecycle hooks & metadata injection
├── incremental/    # incremental / backfill helpers
├── schema/         # schema & naming overrides
├── hashing/        # hashing / surrogate key helpers
```

- One macro per file  
- File name matches macro name  
- Folder name reflects macro purpose  
---

## Usage

Add the package to your dbt project:

```yml
# packages.yml
packages:
  - git: "git@github.com:vafo-digital/vafo-digital-dbt-utils.git"
    revision: v1.0.1
```

Then install dependencies:

```bash
dbt deps
```

Macros will be available automatically.

---

## Conventions

- Macros are **generic and reusable**
- Adapter overrides must keep their required names (e.g. `snowflake__*`)