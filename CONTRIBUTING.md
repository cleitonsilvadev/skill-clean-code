**English** | [Português](docs/CONTRIBUTING.pt-BR.md)

---

# 🤝 Contributing to Clean Code Skill

First off, thank you for considering contributing to the **Clean Code Skill**! It's people like you that help AI coding agents write cleaner, safer, and more maintainable software.

---

## 📑 Table of Contents

- [How Can I Contribute?](#how-can-i-contribute)
  - [Proposing a New Clean Code Rule](#proposing-a-new-clean-code-rule)
  - [Adding Polyglot Code Examples](#adding-polyglot-code-examples)
  - [Improving Installer or Tooling](#improving-installer-or-tooling)
  - [Documentation & Translations](#documentation--translations)
- [Development Workflow](#development-workflow)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Coding Conventions](#coding-conventions)

---

## How Can I Contribute?

### Proposing a New Clean Code Rule

When suggesting a new rule or modifying an existing one:
1. Open an issue using the **[Suggest a Clean Code Rule](https://github.com/cleitonsilvadev/skill-clean-code/issues/new?template=rule_suggestion.md)** template.
2. Provide a clear rationale explaining *why* the rule is necessary and what anti-pattern it prevents.
3. Include concrete **❌ Avoid** and **✅ Prefer** code examples.

### Adding Polyglot Code Examples

Our reference guide (`reference.md`) illustrates universal clean code principles. While examples are primarily in TypeScript, Python, and Go, contributions adding equivalents in **Rust**, **Java**, **C#**, **PHP**, or **Kotlin** are warmly welcome!

### Improving Installer or Tooling

If you find a bug or want to enhance `install.sh` or `Makefile`:
1. Keep the installer POSIX/Bash-compatible.
2. Avoid hardcoding markdown or rule content directly into `install.sh` — reference files in `rules/` or root dynamically.
3. Test locally across all supported modes (`--global`, `--project`, `--cursor`, `--windsurf`, `--uninstall`).

---

## Development Workflow

1. **Fork and Clone:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/skill-clean-code.git
   cd skill-clean-code
   ```

2. **Create a Feature Branch:**
   ```bash
   git checkout -b feat/my-new-feature
   ```

3. **Test the Installer Locally:**
   ```bash
   # Test global install in a temporary prefix
   HOME=/tmp/test-home ./install.sh --global

   # Test Cursor rules generation
   ./install.sh --cursor /tmp/test-project
   ```

---

## Pull Request Guidelines

1. **Keep PRs Focused:** One feature, rule, or fix per PR.
2. **Commit Style:** Use [Conventional Commits](https://www.conventionalcommits.org/) (e.g. `feat: ...`, `fix: ...`, `docs: ...`).
3. **Fill the PR Template:** Complete all sections in `.github/pull_request_template.md`.
4. **Sync Translations:** When editing `README.md` or `INSTALL.md`, remember to update the corresponding file in `docs/`.

Thank you for helping make Clean Code Skill even better!
