---
name: clean-code
description: Use when writing, editing, refactoring or fixing code in any project — creating or changing functions, modules, services, routes, jobs, the data layer, components and hooks. Applies to small tweaks and bug fixes too, and even when the user says nothing about style. Also use before committing or opening a PR with code changes, or when asked to review naming, magic numbers, function size, line spacing and scoping, error handling or the lint gate.
---

# Clean code

## Overview

Clean code rules that hold in any project: names that state intent, functions
that do one thing, errors handled with context, no magic numbers.

**The repository's own convention outranks this skill.** Before writing, look for
`CLAUDE.md`/`AGENTS.md`, `CONVENTIONS.md`, `CONTRIBUTING.md`, `.editorconfig` and
the linter config. Where the repo has its own rule, follow that one; where it is
silent, follow this. Legacy code follows the **Boy Scout Rule**: don't refactor in
bulk — improve what is nearby when you are already touching the file.

## Required checklist when writing/changing code

- [ ] **Early return** instead of nesting `if`/`else`.
- [ ] **Room to breathe** — blank line **before every `if`**, after a block of
      declarations, before a `return`, around a loop. Give any `if`/`for` body that
      does real work its own braces, and keep separating inside them. Only a guard
      clause — an `if` whose whole body is a `return` or a `throw` — stays unbraced,
      even when it wraps to the next line.
- [ ] **No magic numbers** — extract a named constant, in the casing convention of
      the language (`UPPER_SNAKE_CASE` in most).
- [ ] **Immutable by default** — prefer `const`/`final`/`val` plus a named function
      over a mutable variable assigned in an if/else. Mutation only when it is the
      essence of the algorithm (accumulating in a loop).
- [ ] **Small, single-responsibility functions** — one that doesn't fit on a screen
      (~60 lines) is doing too much. Targets: **≤ 4 parameters** (group into an
      object beyond that), cyclomatic complexity **≤ 12**, nesting **≤ 3** — unless
      the repo's linter sets different limits.
- [ ] **Descriptive names**, no needless abbreviations (`qty`, `tmp`, `val`); the
      name says what the thing does or returns.
- [ ] **Language**: code (identifiers, functions, types) in **English** by
      default, unless the project explicitly specifies another language;
      comments, documentation, and user-facing logs follow the project's
      established pattern and tone.
- [ ] **Comments only when non-obvious**, in the language's doc format (JSDoc,
      docstring, `///`). Don't comment the obvious, don't leave stale comments.
- [ ] **Strict comparison** (`===` in JS/TS, the equivalent in your language),
      **interpolation** instead of `+` concatenation, **no `else` after `return`**,
      **no nested ternaries**.
- [ ] **Errors handled with context** (status, message, cause) — never swallow an
      exception silently.
- [ ] **Business logic separated from infrastructure** (DB, HTTP, formatting); less
      coupling, more cohesion, composition over inheritance.
- [ ] **Real DRY**: only merge what changes for the same reason. Dead code goes.

## Extra checklist for React

Only when the project uses React:

- [ ] **Effects don't sync state.** Copying a prop into state inside `useEffect` is
      banned. Reset by remounting (a `key`, or the unmount the dialog library
      already does on close); when remounting won't do, adjust during render with a
      previous-value check.
- [ ] **Effects are for the outside world** (network, timers, DOM, polling). If the
      trigger really is external, keep it and add `eslint-disable-next-line` **with
      the reason** — never a silent exception.
- [ ] **Complete dependency arrays**. Destructure the stable function off the hook
      (`const { mutateAsync } = useX()`) instead of depending on the whole object.
- [ ] **Don't touch generated or vendored code** — shadcn's `components/ui/`,
      generated clients, `dist/`. It is overwritten on the next generation run.

## Validation before finishing

What the linter does **not** catch — function length, magic numbers, SRP, name
intent, coupling — is the author's discipline: re-read the diff against the
checklist above.

Then run the project's gate. Find out what it is instead of guessing: read the
`scripts` in `package.json`, the `Makefile`, `pyproject.toml`/`tox.ini`,
`justfile` or `CONTRIBUTING.md`, and run whatever exists (`lint:check`,
`format:check`, `types:check`, `test`). In a repo with more than one app, run it
**inside the directory you touched** — each app usually has its own config.

**Don't disable a lint rule to make it pass**; fix the cause.

## Full reference

Every rule with a ❌/✅ example is in [reference.md](reference.md) — open it when a
concrete case is unclear.
