#!/usr/bin/env bash

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SKILL_NAME="clean-code"
REPO_RAW_URL="https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" 2>/dev/null)" 2>/dev/null && pwd || echo "")"

print_banner() {
  echo -e "${BLUE}========================================${NC}"
  echo -e "${BLUE}     Clean Code Skill - Instalador     ${NC}"
  echo -e "${BLUE}========================================${NC}"
}

show_help() {
  echo "Uso: ./install.sh [opções] ou curl ... | bash -s -- [opções]"
  echo ""
  echo "Opções:"
  echo "  -g, --global       Instala globalmente em ~/.claude/skills (lido por Claude Code e OpenCode)"
  echo "  -p, --project      Instala localmente no projeto em .claude/skills"
  echo "      --cursor       Gera arquivo .cursorrules no projeto atual para o Cursor"
  echo "      --windsurf     Gera arquivo .windsurfrules no projeto atual para o Windsurf"
  echo "      --hook         Instala Git pre-commit hook no projeto atual (.git/hooks/pre-commit)"
  echo "  -s, --symlink      Cria links simbólicos (requer repositório local)"
  echo "  -u, --uninstall    Remove a skill dos destinos configurados"
  echo "  -h, --help         Exibe esta mensagem de ajuda"
  echo ""
  echo "Exemplos:"
  echo "  ./install.sh                 # Global (~/.claude/skills)"
  echo "  ./install.sh --project       # No projeto atual (.claude/skills)"
  echo "  ./install.sh --cursor        # Gera .cursorrules no projeto atual"
  echo "  ./install.sh --windsurf      # Gera .windsurfrules no projeto atual"
  echo "  ./install.sh --hook          # Instala Git pre-commit hook"
}

# Parse argumentos
MODE="global"
USE_SYMLINK=false
UNINSTALL=false
TARGET_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -g|--global)
      MODE="global"
      shift
      ;;
    -p|--project)
      MODE="project"
      if [[ -n "$2" && "$2" != -* ]]; then
        TARGET_DIR="$2"
        shift
      else
        TARGET_DIR="."
      fi
      shift
      ;;
    --cursor)
      MODE="cursor"
      if [[ -n "$2" && "$2" != -* ]]; then
        TARGET_DIR="$2"
        shift
      else
        TARGET_DIR="."
      fi
      shift
      ;;
    --windsurf)
      MODE="windsurf"
      if [[ -n "$2" && "$2" != -* ]]; then
        TARGET_DIR="$2"
        shift
      else
        TARGET_DIR="."
      fi
      shift
      ;;
    --hook)
      MODE="hook"
      if [[ -n "$2" && "$2" != -* ]]; then
        TARGET_DIR="$2"
        shift
      else
        TARGET_DIR="."
      fi
      shift
      ;;
    -s|--symlink)
      USE_SYMLINK=true
      shift
      ;;
    -u|--uninstall)
      UNINSTALL=true
      shift
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo -e "${RED}Opção inválida: $1${NC}"
      show_help
      exit 1
      ;;
  esac
done

install_rules_file() {
  local src_name="$1"
  local dest_name="$2"
  local dest_file="${TARGET_DIR:-.}/${dest_name}"

  echo -e "${BLUE}Instalando ${dest_name} em ${dest_file}...${NC}"
  if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/rules/${src_name}" ]; then
    cp "$SCRIPT_DIR/rules/${src_name}" "$dest_file"
  else
    curl -fsSL "${REPO_RAW_URL}/rules/${src_name}" -o "$dest_file"
  fi
  echo -e "  ${GREEN}✓${NC} Instalado com sucesso: ${dest_file}"
}

install_git_hook() {
  local target="${TARGET_DIR:-.}"
  local hooks_dir="${target}/.git/hooks"

  if [ ! -d "${target}/.git" ]; then
    echo -e "  ${RED}✗${NC} Diretório '${target}' não é um repositório Git (.git não encontrado)."
    exit 1
  fi

  mkdir -p "$hooks_dir"
  local dest_file="${hooks_dir}/pre-commit"

  echo -e "${BLUE}Instalando pre-commit hook em ${dest_file}...${NC}"
  if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/rules/pre-commit" ]; then
    cp "$SCRIPT_DIR/rules/pre-commit" "$dest_file"
  else
    curl -fsSL "${REPO_RAW_URL}/rules/pre-commit" -o "$dest_file"
  fi
  chmod +x "$dest_file"
  echo -e "  ${GREEN}✓${NC} Hook pre-commit instalado e ativado com sucesso!"
}

install_to_path() {
  local base_dir="$1"
  local dest_dir="${base_dir}/${SKILL_NAME}"

  mkdir -p "$base_dir"

  if [ -e "$dest_dir" ] || [ -L "$dest_dir" ]; then
    rm -rf "$dest_dir"
  fi

  if [ "$USE_SYMLINK" = true ]; then
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ]; then
      ln -s "$SCRIPT_DIR" "$dest_dir"
      echo -e "  ${GREEN}✓${NC} Symlink criado em: ${dest_dir} -> ${SCRIPT_DIR}"
    else
      echo -e "  ${RED}✗${NC} Modo symlink requer execução a partir do repositório local."
      exit 1
    fi
  else
    mkdir -p "$dest_dir"
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ]; then
      cp "$SCRIPT_DIR/SKILL.md" "$dest_dir/"
      cp "$SCRIPT_DIR/reference.md" "$dest_dir/"
    else
      echo -e "  ${BLUE}Baixando arquivos da skill...${NC}"
      curl -fsSL "${REPO_RAW_URL}/SKILL.md" -o "${dest_dir}/SKILL.md"
      curl -fsSL "${REPO_RAW_URL}/reference.md" -o "${dest_dir}/reference.md"
    fi
    echo -e "  ${GREEN}✓${NC} Instalado com sucesso em: ${dest_dir}"
  fi
}

uninstall_from_path() {
  local base_dir="$1"
  local dest_dir="${base_dir}/${SKILL_NAME}"

  if [ -e "$dest_dir" ] || [ -L "$dest_dir" ]; then
    rm -rf "$dest_dir"
    echo -e "  ${YELLOW}✓${NC} Removido de: ${dest_dir}"
  fi
}

print_banner

if [ "$UNINSTALL" = true ]; then
  echo -e "${YELLOW}Removendo Clean Code Skill...${NC}"
  uninstall_from_path "$HOME/.claude/skills"
  uninstall_from_path "$HOME/.agents/skills"
  uninstall_from_path "$HOME/.config/opencode/skills"
  uninstall_from_path "./.claude/skills"
  uninstall_from_path "./.agents/skills"
  uninstall_from_path "./.opencode/skills"
  rm -f ./.cursorrules ./.windsurfrules ./.git/hooks/pre-commit
  echo -e "${GREEN}Desinstalação concluída com sucesso!${NC}"
  exit 0
fi

if [ "$MODE" = "global" ]; then
  echo -e "${BLUE}Instalando globalmente em ~/.claude/skills (lido por Claude Code e OpenCode)...${NC}"
  install_to_path "$HOME/.claude/skills"
elif [ "$MODE" = "project" ]; then
  echo -e "${BLUE}Instalando no projeto (${TARGET_DIR}/.claude/skills)...${NC}"
  install_to_path "${TARGET_DIR}/.claude/skills"
elif [ "$MODE" = "cursor" ]; then
  install_rules_file "cursorrules" ".cursorrules"
elif [ "$MODE" = "windsurf" ]; then
  install_rules_file "windsurfrules" ".windsurfrules"
elif [ "$MODE" = "hook" ]; then
  install_git_hook
fi

echo ""
echo -e "${GREEN}🎉 Clean Code Skill instalada com sucesso!${NC}"
if [ "$USE_SYMLINK" = true ]; then
  echo -e "${BLUE}Nota:${NC} As alterações feitas no repositório serão refletidas imediatamente na skill."
fi
