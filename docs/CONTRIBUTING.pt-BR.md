[English](../CONTRIBUTING.md) | **Português**

---

# 🤝 Guia de Contribuição — Clean Code Skill

Antes de mais nada, muito obrigado pelo interesse em contribuir com a **Clean Code Skill**! São desenvolvedores como você que ajudam assistentes de IA a gerar códigos mais limpos, legíveis e sustentáveis.

---

## 📑 Índice

- [Como Posso Contribuir?](#como-posso-contribuir)
  - [Propondo uma Nova Regra de Clean Code](#propondo-uma-nova-regra-de-clean-code)
  - [Adicionando Exemplos de Outras Linguagens](#adicionando-exemplos-de-outras-linguagens)
  - [Melhorando o Instalador ou Scripts](#melhorando-o-instalador-ou-scripts)
  - [Documentação e Traduções](#documentacao-e-traducoes)
- [Fluxo de Desenvolvimento](#fluxo-de-desenvolvimento)
- [Diretrizes para Pull Requests](#diretrizes-para-pull-requests)

---

## Como Posso Contribuir?

### Propondo uma Nova Regra de Clean Code

Ao sugerir uma nova diretriz ou ajustar uma regra existente:
1. Abra uma issue usando o template **[Sugerir Regra](https://github.com/cleitonsilvadev/skill-clean-code/issues/new?template=rule_suggestion.md)**.
2. Forneça uma justificativa clara explicando *por que* a regra é necessária e qual anti-pattern ela evita.
3. Inclua exemplos práticos de **❌ Evitar** e **✅ Preferir**.

### Adicionando Exemplos de Outras Linguagens

Nosso guia de referência (`reference.md`) ilustra princípios universais de Clean Code. Embora a maioria dos exemplos atuais esteja em TypeScript, Python e Go, contribuições com equivalências em **Rust**, **Java**, **C#**, **PHP** ou **Kotlin** são muito bem-vindas!

### Melhorando o Instalador ou Scripts

Caso encontre algum bug ou deseje melhorar o `install.sh` ou `Makefile`:
1. Mantenha o script compatível com Bash / POSIX.
2. Não insira textos ou regras estáticas hardcoded dentro do `install.sh` — use arquivos sob demanda em `rules/` ou na raiz.
3. Teste localmente todos os modos suportados (`--global`, `--project`, `--cursor`, `--windsurf`, `--uninstall`).

---

## Fluxo de Desenvolvimento

1. **Fork e Clone:**
   ```bash
   git clone https://github.com/SEU_USUARIO/skill-clean-code.git
   cd skill-clean-code
   ```

2. **Crie uma Branch:**
   ```bash
   git checkout -b feat/minha-melhoria
   ```

3. **Teste o Instalador Localmente:**
   ```bash
   # Teste instalação global em diretório temporário
   HOME=/tmp/test-home ./install.sh --global

   # Teste geração de regras do Cursor
   ./install.sh --cursor /tmp/test-project
   ```

---

## Diretrizes para Pull Requests

1. **PRs Focados:** Uma funcionalidade, regra ou correção por PR.
2. **Padrão de Commits:** Utilize [Conventional Commits](https://www.conventionalcommits.org/) (ex: `feat: ...`, `fix: ...`, `docs: ...`).
3. **Preencha o Template:** Complete os campos solicitados em `.github/pull_request_template.md`.
4. **Sincronize Traduções:** Ao alterar o `README.md` ou `INSTALL.md`, atualize também as versões correspondentes na pasta `docs/`.

Muito obrigado pela sua contribuição!
