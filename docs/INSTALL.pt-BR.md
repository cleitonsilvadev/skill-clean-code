[English](INSTALL.md) | **Português**

---

# 📦 Guia de Instalação — Clean Code Skill

Este guia detalha todas as formas de instalar, atualizar e remover a **Clean Code Skill** para assistentes de IA como **Claude Code**, **OpenCode** e ferramentas compatíveis com o padrão **Agent Skills**.

---

## 📑 Índice

- [⚡ 1. Instalação Rápida via `curl` ou `npx` (Recomendado)](#1-instalacao-rapida-via-curl-ou-npx)
- [🐙 2. Instalação via `git clone`](#2-instalacao-via-git-clone)
- [🔗 3. Instalação via Symlink (Modo Desenvolvedor)](#3-instalacao-via-symlink)
- [📁 4. Instalação por Projeto (Compartilhamento com a Equipe)](#4-instalacao-por-projeto)
- [💻 5. Integração com Cursor e Windsurf](#5-integracao-com-cursor-e-windsurf)
- [🪝 6. Git Pre-Commit Hook](#6-git-pre-commit-hook)
- [🛠️ 7. Usando o Script Local (`install.sh` ou `Makefile`)](#7-usando-o-script-local)
- [🔄 Como Atualizar](#como-atualizar)
- [🗑️ Como Desinstalar](#como-desinstalar)

---

<a id="1-instalacao-rapida-via-curl-ou-npx"></a>
## ⚡ 1. Instalação Rápida via `curl` ou `npx` (Recomendado)

A forma mais rápida de instalar sem precisar clonar repositório manualmente.

### Via `curl`:

**Global (Claude Code e OpenCode):**
```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash
```

**Por Projeto (diretório atual):**
```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --project
```

### Via `npx`:

Execute diretamente via Node.js / npm:

```bash
npx skill-clean-code
npx skill-clean-code --project
npx skill-clean-code --cursor
npx skill-clean-code --windsurf
npx skill-clean-code --hook
```

Você também pode especificar um caminho de projeto personalizado:

```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --project /caminho/do/projeto
```

---

<a id="2-instalacao-via-git-clone"></a>
## 🐙 2. Instalação via `git clone`

Ideal para manter um repositório git gerenciável e atualizável via `git pull`.

### Para Claude Code & OpenCode:

```bash
git clone https://github.com/cleitonsilvadev/skill-clean-code.git ~/.claude/skills/clean-code
```

> **Nota:** O OpenCode descobre e carrega automaticamente as skills localizadas em `~/.claude/skills/`. Uma única instalação atende a ambos os assistentes!

### Como atualizar via Git:

```bash
git -C ~/.claude/skills/clean-code pull
```

---

<a id="3-instalacao-via-symlink"></a>
## 🔗 3. Instalação via Symlink (Modo Desenvolvedor)

Se você clonou este repositório em sua máquina (por exemplo, em `~/projects/skill-clean-code`) e deseja fazer alterações na skill ou no guia de referência que tenham **efeito imediato** sem precisar reinstalar:

```bash
mkdir -p ~/.claude/skills

# Symlink para Claude Code e OpenCode
ln -s ~/projects/skill-clean-code ~/.claude/skills/clean-code
```

---

<a id="4-instalacao-por-projeto"></a>
## 📁 4. Instalação por Projeto (Compartilhamento com a Equipe)

Para garantir que todos os desenvolvedores e agentes trabalhando no mesmo repositório sigam as mesmas diretrizes:

### Como pasta direta:

```bash
git clone https://github.com/cleitonsilvadev/skill-clean-code.git .claude/skills/clean-code
```

### Como Git Submodule:

```bash
git submodule add https://github.com/cleitonsilvadev/skill-clean-code.git .claude/skills/clean-code
```

---

<a id="5-integracao-com-cursor-e-windsurf"></a>
## 💻 5. Integração com Cursor e Windsurf

Você pode gerar os arquivos nativos de regras para o Cursor (`.cursorrules`) ou Windsurf (`.windsurfrules`) diretamente no seu workspace:

### Via comando `curl`:

```bash
# Gerar .cursorrules para o Cursor
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --cursor

# Gerar .windsurfrules para o Windsurf
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --windsurf
```

### A partir do repositório clonado ou Makefile:

```bash
./install.sh --cursor      # ou: make cursor
./install.sh --windsurf    # ou: make windsurf
```

---

<a id="6-git-pre-commit-hook"></a>
## 🪝 6. Git Pre-Commit Hook

Instale um hook de pre-commit no seu repositório (`.git/hooks/pre-commit`) para alertar sobre instruções de depuração deixadas acidentalmente antes de cada commit:

```bash
# Via curl
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash -s -- --hook

# Via npx
npx skill-clean-code --hook

# A partir do repositório clonado ou Makefile
./install.sh --hook        # ou: make hook
```

---

<a id="7-usando-o-script-local"></a>
## 🛠️ 7. Usando o Script Local (`install.sh` ou `Makefile`)

Se você já clonou este repositório localmente:

### Usando o `install.sh`:

```bash
# Instalação global padrão (cópia)
./install.sh

# Instalação com symlink
./install.sh --symlink

# Instalação no diretório do projeto atual
./install.sh --project

# Ver todas as opções
./install.sh --help
```

### Usando o `Makefile`:

```bash
make install    # Instalação global (cópia)
make link       # Instalação global via symlink
make project    # Instalação no projeto atual
make uninstall  # Desinstalação completa
make help       # Lista todos os comandos disponíveis
```

---

<a id="como-atualizar"></a>
## 🔄 Como Atualizar

- **Se instalou via `curl`:** Basta rodar novamente o comando de instalação via `curl`. Os arquivos existentes serão sobrescritos com as versões mais recentes.
- **Se instalou via `git clone`:** Execute `git -C <pasta_da_skill> pull`.
- **Se instalou via Symlink:** Suas alterações no repositório já estão sincronizadas em tempo real.

---

<a id="como-desinstalar"></a>
## 🗑️ Como Desinstalar

Para remover a skill dos diretórios padrão:

```bash
# Usando o instalador
./install.sh --uninstall

# Ou via make
make uninstall

# Ou manualmente
rm -rf ~/.claude/skills/clean-code
rm -rf .claude/skills/clean-code
```
