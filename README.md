**English** | [Português](docs/README.pt-BR.md)

---

# 🧹 Clean Code Skill

[![npm version](https://img.shields.io/npm/v/skill-clean-code.svg?color=cb3837)](https://www.npmjs.com/package/skill-clean-code)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/cleitonsilvadev/skill-clean-code/actions/workflows/ci.yml/badge.svg)](https://github.com/cleitonsilvadev/skill-clean-code/actions/workflows/ci.yml)
[![Compatible with](https://img.shields.io/badge/Compatible%20with-Claude%20Code%20%7C%20OpenCode%20%7C%20Cursor%20%7C%20Windsurf-black)](https://github.com/cleitonsilvadev/skill-clean-code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> **Universal Clean Code Skill for AI agents** ([Claude Code](https://claude.ai/code), [OpenCode](https://opencode.ai), Cursor, Windsurf, and tools compatible with the **Agent Skills** specification).

This skill injects strict rules for readability, clean architecture, maintainability, and software quality into the reasoning loop of autonomous coding assistants, guiding everything from function creation and editing to refactoring and pre-commit/PR reviews.

---

## 📑 Table of Contents

- [⚡ Quick Start](#quick-start)
- [🎯 Core Philosophy & Principles](#core-philosophy--principles)
- [📊 Rules and Guidelines Table](#rules-and-guidelines-table)
- [📋 Detailed Skill Contents](#detailed-skill-contents)
  - [1. Flow Control & Readability](#1-flow-control--readability)
  - [2. Naming & Constants](#2-naming--constants)
  - [3. Immutability & Scope](#3-immutability--scope)
  - [4. Function Size & Complexity (SRP)](#4-function-size--complexity-srp)
  - [5. Syntax & Clean Comparisons](#5-syntax--clean-comparisons)
  - [6. Context-Rich Error Handling](#6-context-rich-error-handling)
  - [7. Architecture & Cohesion](#7-architecture--cohesion)
  - [8. React-Specific Guidelines](#8-react-specific-guidelines)
  - [9. Quality Gate & Discipline](#9-quality-gate--discipline)
- [🤖 How AI Agents Use This Skill](#how-ai-agents-use-this-skill)
- [📦 Complete Installation Guide (docs/INSTALL.md)](docs/INSTALL.md)
- [📖 Practical Reference Catalog (reference.md)](reference.md)
- [🤝 Contributing (CONTRIBUTING.md)](CONTRIBUTING.md)
- [📄 License](#license)

---

<a id="quick-start"></a>
## ⚡ Quick Start

Install globally with a single command via `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash
```

Or run directly using `npx`:

```bash
npx skill-clean-code
```

> 📖 **Need advanced options (per project, Cursor, Windsurf, Git hooks, symlinks)?**  
> Check the [**Complete Installation Guide (docs/INSTALL.md)**](docs/INSTALL.md).

---

<a id="core-philosophy--principles"></a>
## 🎯 Core Philosophy & Principles

1. **Universal rules that hold in any project and stack:** Intent-revealing names, single-responsibility functions, context-rich error handling, and elimination of magic numbers.
2. **Precedence of repository conventions:** Local project rules (`CLAUDE.md`, `AGENTS.md`, `CONVENTIONS.md`, `.editorconfig`, linters) **always take precedence**. The skill steps in where the repo is silent.
3. **Boy Scout Rule:** In legacy codebases, avoid massive out-of-scope refactoring — surgically improve the code surrounding what you are already touching.
4. **Discipline beyond the linter:** Cohesion, naming clarity, function size, and complexity containment depend on developer/agent discipline before declaring a task complete.

---

<a id="rules-and-guidelines-table"></a>
## 📊 Rules and Guidelines Table

Index of all rules from the skill checklist (click the `#` number to jump to the detailed explanation):

| # | Rule | Category | Description |
| :-: | :--- | :--- | :--- |
| [**01**](#rule-early-return) | **Early Return** | Flow Control | Early exit to prevent deep `if`/`else` nesting |
| [**02**](#rule-room-to-breathe) | **Room to Breathe** | Flow Control | Vertical blank lines before conditionals, loops, and returns |
| [**03**](#rule-no-magic-numbers) | **No Magic Numbers** | Naming & Constants | Extract literals and numerical constants to named constants |
| [**04**](#rule-immutable-by-default) | **Immutable by Default** | Immutability | Favor `const` and pure helper functions over mutable `let` in branches |
| [**05**](#rule-small-functions-srp) | **Small Functions (SRP)** | Complexity | Single responsibility functions (≤ 60 lines, ≤ 4 params, complexity ≤ 12) |
| [**06**](#rule-descriptive-names) | **Descriptive Names** | Naming & Constants | Intent-revealing names without vague abbreviations (`qty`, `val`) |
| [**07**](#rule-language-convention) | **Language Convention** | Naming & Constants | English by default unless project explicitly specifies otherwise |
| [**08**](#rule-valuable-comments) | **Valuable Comments** | Naming & Constants | Focus on the *why*, never state the obvious or repeat the code |
| [**09**](#rule-strict-comparison) | **Strict Comparison** | Best Practices | Mandatory `===` / `!==` avoiding implicit type coercion |
| [**10**](#rule-no-else-after-return) | **No Else After Return** | Best Practices | Remove redundant `else` branches after returning or throwing |
| [**11**](#rule-string-interpolation) | **String Interpolation** | Best Practices | Use template literals instead of manual concatenation with `+` |
| [**12**](#rule-no-nested-ternaries) | **No Nested Ternaries** | Best Practices | Replace nested ternary operators with guard clauses or helper functions |
| [**13**](#rule-errors-with-context) | **Context-Rich Errors** | Error Handling | Propagate errors with status, clear message, and `cause`; never swallow |
| [**14**](#rule-layer-separation) | **Layer Separation** | Architecture | Decouple business logic from HTTP frameworks, DB, and view formatting |
| [**15**](#rule-real-dry) | **Real DRY** | Architecture | Reuse code only when it changes for the same underlying reason |
| [**16**](#rule-react-no-sync-effects) | **React: No Sync Effects** | React | Never copy props to state inside `useEffect` |
| [**17**](#rule-react-effects-boundary) | **React: Effects Boundary** | React | Reserve `useEffect` strictly for external synchronization (DOM, timers, network) |
| [**18**](#rule-react-complete-deps) | **React: Complete Deps** | React | Keep dependency arrays complete; destructure stable hooks |
| [**19**](#rule-react-untouched-generated) | **Untouched Generated Code** | React | Never manually edit generated or vendored files (`components/ui/`, dist) |
| [**20**](#rule-quality-gate-discipline) | **Quality Gate Discipline** | Validation | Diff review against checklist and running tests/linters without disabling rules |

---

<a id="detailed-skill-contents"></a>
## 📋 Detailed Skill Contents

The skill instructs AI agents to strictly adhere to the following areas:

### 1. Flow Control & Readability
- <a id="rule-early-return"></a>[**Early Return**](reference.md#2-functions): Use early exits and guard clauses instead of nesting multiple levels of `if`/`else`.
- <a id="rule-room-to-breathe"></a>[**Room to Breathe**](reference.md#5-room-to-breathe-and-explicit-scopes) (Vertical Spacing): Blank lines before every `if`, after variable declarations, before `return`, and around loops.
- <a id="rule-guard-clauses"></a>[**Guard Clauses**](reference.md#5-room-to-breathe-and-explicit-scopes): Only a guard clause whose whole body is a single `return` or `throw` stays unbraced. Any block performing real work requires explicit braces.

### 2. Naming & Constants
- <a id="rule-descriptive-names"></a>[**Clear Intent**](reference.md#1-names-and-intent): Descriptive names stating what the variable holds or what the function does/returns, without needless abbreviations (`qty`, `tmp`, `val`, `data2`).
- <a id="rule-no-magic-numbers"></a>[**No Magic Numbers**](reference.md#3-constants-vs-magic-numbers): Extract numeric or literal values to named constants (e.g., `UPPER_SNAKE_CASE`).
- <a id="rule-language-convention"></a>[**Language Convention**](reference.md#1-names-and-intent): Write code (identifiers, functions, types) in **English** by default, unless the project explicitly specifies another language; comments, documentation, and user-facing logs follow the pattern and tone established in the project.
- <a id="rule-valuable-comments"></a>[**Comments for the Non-Obvious**](reference.md#6-comments-only-when-non-obvious): Concise JSDoc/docstrings focusing on *why*, never narrating what the code visibly does.

### 3. Immutability & Scope
- <a id="rule-immutable-by-default"></a>[**Immutable by Default**](reference.md#4-immutability--avoid-a-mutable-variable-decided-in-an-ifelse): Prefer `const`/`readonly` plus named pure functions over mutable variables (`let`) reassigned across conditional branches.
- [**Restricted Mutation**](reference.md#4-immutability--avoid-a-mutable-variable-decided-in-an-ifelse): `let` is reserved strictly when mutation is the essence of the algorithm (e.g., loop accumulators).

### 4. Function Size & Complexity (SRP)
- <a id="rule-small-functions-srp"></a>[**Single Responsibility Principle (SRP)**](reference.md#2-functions): Each function must do one thing only.
- **Visual Size:** Functions should comfortably fit on a screen (~60 lines). Beyond that, they are doing too much.
- **Threshold Metrics:**
  - Maximum **≤ 4 parameters** (group into an object/interface beyond that).
  - Cyclomatic complexity **≤ 12**.
  - Nesting depth **≤ 3**.

### 5. Syntax & Clean Comparisons
- <a id="rule-strict-comparison"></a>[**Strict Comparison**](reference.md#7-readability-and-simplicity): Mandatory `===` / `!==` (in JS/TS) to prevent implicit type coercion bugs.
- <a id="rule-string-interpolation"></a>[**String Interpolation**](reference.md#7-readability-and-simplicity): Use template literals (e.g. `` `User ${id}` ``) instead of `+` concatenation.
- <a id="rule-no-else-after-return"></a>[**No Redundant Else**](reference.md#2-functions): Never write an `else` branch after a block that already terminated execution with `return` or `throw`.
- <a id="rule-no-nested-ternaries"></a>[**No Nested Ternaries**](reference.md#7-readability-and-simplicity): Nested ternaries impair readability; use guard clauses or dedicated helper functions.

### 6. Context-Rich Error Handling
- <a id="rule-errors-with-context"></a>[**Never Swallow Exceptions**](reference.md#9-error-handling): Capturing errors without proper handling or logging (`catch {}`) is strictly prohibited.
- [**Full Context**](reference.md#9-error-handling): Propagated or logged errors must include status, clear human-readable message, and original `cause`.

### 7. Architecture & Cohesion
- <a id="rule-layer-separation"></a>[**Decoupling**](reference.md#8-coupling-and-cohesion): Separate core business logic from infrastructure (database queries, HTTP controllers, view formatting).
- <a id="rule-real-dry"></a>[**Real DRY**](reference.md#8-coupling-and-cohesion): Merge code only when it changes **for the exact same reason**; do not artificially unify distinct logic that temporarily looks similar.

### 8. React-Specific Guidelines
- <a id="rule-react-no-sync-effects"></a>[**Effects Do Not Sync State**](reference.md#10-react--an-effect-is-not-for-syncing-state): Never copy props into state inside `useEffect`. Reset with `key` or compute derived state during rendering.
- <a id="rule-react-effects-boundary"></a>[**Effects are for External Systems**](reference.md#10-react--an-effect-is-not-for-syncing-state): Reserve `useEffect` for networks, timers, DOM listeners, or polling.
- <a id="rule-react-complete-deps"></a>[**Complete Dependency Arrays**](reference.md#10-react--an-effect-is-not-for-syncing-state): Never omit dependencies; destructure stable hooks (`const { mutateAsync } = useX()`).
- <a id="rule-react-untouched-generated"></a>[**Untouched Generated Code**](reference.md#10-react--an-effect-is-not-for-syncing-state): Never manually alter vendored or generated code (e.g., `shadcn/ui`, Prisma clients, `dist/`).

### 9. Quality Gate & Discipline
- <a id="rule-quality-gate-discipline"></a>[**Active Diff Review**](reference.md#12-human-judgment-not-mechanizable): The author/agent must review diffs against this checklist before considering work finished.
- [**Repository Quality Gate**](reference.md#11-boy-scout-rule): Always run the repository's verification commands (`yarn lint:check`, `npm test`, `pytest`, `tsc`).
- **Never Bypass Linters:** Never disable lint rules to force CI green; fix the root cause.

---

<a id="how-ai-agents-use-this-skill"></a>
## 🤖 How AI Agents Use This Skill

This skill complies with the Claude Code / OpenCode standard specification:

1. **Automatic Discovery:** `SKILL.md` contains YAML frontmatter with `name: clean-code` and semantic triggers.
2. **Autonomous Activation:** When asked to write, refactor, edit code, or submit PRs, the agent loads this skill proactively.
3. **Direct Invocation:** Users can enforce or request reviews directly (e.g., *"Review this file against the clean-code skill"*).
4. **Reference Guide Consultation:** For ambiguous patterns, agents consult real-world examples in `reference.md`.

---

<a id="license"></a>
## 📄 License

Distributed under the MIT License. Feel free to use, customize, and extend for personal or commercial projects.
