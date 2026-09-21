.PHONY: install link project cursor windsurf hook uninstall help

help:
	@echo "Clean Code Skill - Comandos disponíveis:"
	@echo "  make install    - Instala globalmente (cópia dos arquivos)"
	@echo "  make link       - Instala globalmente com symlink (desenvolvimento)"
	@echo "  make project    - Instala no diretório atual (.claude e .agents)"
	@echo "  make cursor     - Gera .cursorrules no diretório atual"
	@echo "  make windsurf   - Gera .windsurfrules no diretório atual"
	@echo "  make hook       - Instala Git pre-commit hook no projeto atual"
	@echo "  make uninstall  - Remove a skill global e localmente"

install:
	@chmod +x install.sh
	@./install.sh --global

link:
	@chmod +x install.sh
	@./install.sh --global --symlink

project:
	@chmod +x install.sh
	@./install.sh --project

cursor:
	@chmod +x install.sh
	@./install.sh --cursor

windsurf:
	@chmod +x install.sh
	@./install.sh --windsurf

hook:
	@chmod +x install.sh
	@./install.sh --hook

uninstall:
	@chmod +x install.sh
	@./install.sh --uninstall
