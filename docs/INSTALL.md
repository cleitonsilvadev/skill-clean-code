**English** | [Português](INSTALL.pt-BR.md)

---

# 📦 Installation Guide — Clean Code Skill

This guide details all ways to install, update, and remove the **Clean Code Skill** for AI coding assistants such as **Claude Code**, **OpenCode**, and tools compatible with the **Agent Skills** specification.

---

## 📑 Table of Contents

- [⚡ 1. Quick Installation via `curl` or `npx` (Recommended)](#1-quick-installation-via-curl-or-npx)
- [🐙 2. Installation via `git clone`](#2-installation-via-git-clone)
- [🔗 3. Installation via Symlink (Developer Mode)](#3-installation-via-symlink)
- [📁 4. Per-Project Installation (Sharing with Your Team)](#4-per-project-installation)
- [💻 5. Cursor & Windsurf Integration](#5-cursor-and-windsurf-integration)
- [🪝 6. Git Pre-Commit Hook](#6-git-pre-commit-hook)
- [🛠️ 7. Using the Local Script (`install.sh` or `Makefile`)](#7-using-the-local-script)
- [🔄 How to Update](#how-to-update)
- [🗑️ How to Uninstall](#how-to-uninstall)

---

<a id="1-quick-installation-via-curl-or-npx"></a>
## ⚡ 1. Quick Installation via `curl` or `npx` (Recommended)

The fastest way to install without needing to manually clone a repository.

### Via `curl`:

**Global (Claude Code and OpenCode):**
```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash
```

**Per Project (current directory):**
```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --project
```

### Via `npx`:

Run directly with Node.js / npm:

```bash
npx skill-clean-code
npx skill-clean-code --project
npx skill-clean-code --cursor
npx skill-clean-code --windsurf
npx skill-clean-code --hook
```

You can also specify a custom project path:

```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --project /path/to/project
```

---

<a id="2-installation-via-git-clone"></a>
## 🐙 2. Installation via `git clone`

Ideal for keeping a manageable Git repository updated via `git pull`.

### For Claude Code & OpenCode:

```bash
git clone https://github.com/cleitonsilvadev/skill-clean-code.git ~/.claude/skills/clean-code
```

> **Note:** OpenCode automatically discovers and loads skills located in `~/.claude/skills/`. A single installation serves both assistants!

### How to update via Git:

```bash
git -C ~/.claude/skills/clean-code pull
```

---

<a id="3-installation-via-symlink"></a>
## 🔗 3. Installation via Symlink (Developer Mode)

If you have cloned this repository on your machine (e.g., in `~/projects/skill-clean-code`) and want to edit the skill or the reference guide with **immediate effect** without reinstalling:

```bash
mkdir -p ~/.claude/skills

# Symlink for Claude Code and OpenCode
ln -s ~/projects/skill-clean-code ~/.claude/skills/clean-code
```

---

<a id="4-per-project-installation"></a>
## 📁 4. Per-Project Installation (Sharing with Your Team)

To ensure all developers and AI agents working on the same repository follow the exact same standards:

### As a standalone cloned folder:

```bash
git clone https://github.com/cleitonsilvadev/skill-clean-code.git .claude/skills/clean-code
```

### As a Git Submodule:

```bash
git submodule add https://github.com/cleitonsilvadev/skill-clean-code.git .claude/skills/clean-code
```

---

<a id="5-cursor-and-windsurf-integration"></a>
## 💻 5. Cursor & Windsurf Integration

You can generate native rule files for Cursor (`.cursorrules`) or Windsurf (`.windsurfrules`) directly in your workspace:

### Via `curl` one-liner:

```bash
# Generate .cursorrules for Cursor
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --cursor

# Generate .windsurfrules for Windsurf
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --windsurf
```

### From cloned repository or Makefile:

```bash
./install.sh --cursor      # or: make cursor
./install.sh --windsurf    # or: make windsurf
```

---

<a id="6-git-pre-commit-hook"></a>
## 🪝 6. Git Pre-Commit Hook

Install an automated pre-commit hook in your project (`.git/hooks/pre-commit`) that checks staged changes for leftover debug statements before every commit:

```bash
# Via curl
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --hook

# Via npx
npx skill-clean-code --hook

# From cloned repository or Makefile
./install.sh --hook        # or: make hook
```

---

<a id="7-using-the-local-script"></a>
## 🛠️ 7. Using the Local Script (`install.sh` or `Makefile`)

If you have already cloned this repository locally:

### Using `install.sh`:

```bash
# Default global installation (copy files)
./install.sh

# Installation with symlink
./install.sh --symlink

# Installation in current project directory
./install.sh --project

# View all options
./install.sh --help
```

### Using the `Makefile`:

```bash
make install    # Global installation (copy)
make link       # Global installation via symlink
make project    # Install in current project
make uninstall  # Complete uninstallation
make help       # List all available commands
```

---

<a id="how-to-update"></a>
## 🔄 How to Update

- **If installed via `curl`:** Simply re-run the installation command via `curl`. Existing files will be overwritten with the latest versions.
- **If installed via `git clone`:** Run `git -C <skill_directory> pull`.
- **If installed via Symlink:** Your changes in the cloned repo are reflected in real time automatically.

---

<a id="how-to-uninstall"></a>
## 🗑️ How to Uninstall

To remove the skill from default directories:

```bash
# Using the installer
./install.sh --uninstall

# Or using make
make uninstall

# Or manually
rm -rf ~/.claude/skills/clean-code
rm -rf .claude/skills/clean-code
```
