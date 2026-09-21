[English](../README.md) | **Português**

---

# 🧹 Clean Code Skill

[![Licença: MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg)](../LICENSE)
[![CI](https://github.com/cleitonsilvadev/skill-clean-code/actions/workflows/ci.yml/badge.svg)](https://github.com/cleitonsilvadev/skill-clean-code/actions/workflows/ci.yml)
[![Compatível com](https://img.shields.io/badge/Compat%C3%ADvel%20com-Claude%20Code%20%7C%20OpenCode%20%7C%20Cursor%20%7C%20Windsurf-black)](https://github.com/cleitonsilvadev/skill-clean-code)
[![PRs Bem-vindos](https://img.shields.io/badge/PRs-bem--vindos-brightgreen.svg)](CONTRIBUTING.pt-BR.md)

> **Skill universal de Clean Code para agentes de IA** ([Claude Code](https://claude.ai/code), [OpenCode](https://opencode.ai), Cursor, Windsurf e ferramentas compatíveis com o padrão **Agent Skills**).

Esta skill injeta regras estritas de legibilidade, arquitetura limpa, manutenibilidade e qualidade de software no ciclo de raciocínio de assistentes autônomos de código, orientando desde a criação e edição de funções até refatorações e revisões pré-commit/PR.

---

## 📑 Índice

- [⚡ Instalação Rápida](#instalacao-rapida)
- [🎯 Filosofia e Princípios Fundamentais](#filosofia-e-principios-fundamentais)
- [📊 Tabela de Regras e Diretrizes](#tabela-de-regras-e-diretrizes)
- [📋 Conteúdo Detalhado da Skill](#conteudo-detalhado-da-skill)
  - [1. Fluxo de Controle e Legibilidade](#1-fluxo-de-controle-e-legibilidade)
  - [2. Nomenclatura e Constantes](#2-nomenclatura-e-constantes)
  - [3. Imutabilidade e Escopo](#3-imutabilidade-e-escopo)
  - [4. Tamanho de Funções e Complexidade (SRP)](#4-tamanho-de-funções-e-complexidade-srp)
  - [5. Boas Práticas Sintáticas](#5-boas-práticas-sintáticas)
  - [6. Tratamento de Erros Contextualizado](#6-tratamento-de-erros-contextualizado)
  - [7. Arquitetura e Coesão](#7-arquitetura-e-coesão)
  - [8. Diretrizes Específicas para React](#8-diretrizes-específicas-para-react)
  - [9. Portão de Validação e Qualidade](#9-portão-de-validação-e-qualidade)
- [🤖 Como os Agentes de IA Utilizam esta Skill](#como-os-agentes-de-ia-utilizam-esta-skill)
- [📦 Guia Completo de Instalação (INSTALL.pt-BR.md)](INSTALL.pt-BR.md)
- [📖 Catálogo de Referência Prática (reference.md)](../reference.md)
- [🤝 Como Contribuir (CONTRIBUTING.pt-BR.md)](CONTRIBUTING.pt-BR.md)
- [📄 Licença](#licenca)

---

<a id="instalacao-rapida"></a>
## ⚡ Instalação Rápida

Instale globalmente com apenas um comando via `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/cleitonsilvadev/skill-clean-code/main/install.sh | bash
```

Ou execute diretamente usando `npx`:

```bash
npx skill-clean-code
```

> 📖 **Precisa de opções avançadas (por projeto, Cursor, Windsurf, Git hook, desinstalação)?**  
> Veja o [**Guia Completo de Instalação (INSTALL.pt-BR.md)**](INSTALL.pt-BR.md).

---

<a id="filosofia-e-principios-fundamentais"></a>
## 🎯 Filosofia e Princípios Fundamentais

1. **Regras universais que se aplicam a qualquer projeto e stack:** Identificadores que revelam intenção, funções com responsabilidade única, erros sempre com contexto e eliminação de números mágicos.
2. **Precedência das convenções do repositório:** As convenções locais do projeto (`CLAUDE.md`, `AGENTS.md`, `CONVENTIONS.md`, `.editorconfig`, linters) **têm prioridade máxima**. A skill atua onde o repositório é omisso.
3. **Boy Scout Rule (Regra do Escoteiro):** Em bases de código legadas, evite refatorações massivas fora de escopo — melhore de forma cirúrgica o código ao redor do que você já está alterando.
4. **Disciplina além do Linter:** Questões como coesão, clareza de nomes, tamanho de funções e acomodação de complexidade dependem da disciplina do desenvolvedor/agente antes de considerar a tarefa pronta.

---

<a id="tabela-de-regras-e-diretrizes"></a>
## 📊 Tabela de Regras e Diretrizes

Abaixo está o índice de todas as regras presentes no checklist da skill (clique no número `#` para ir direto à explicação detalhada):

| # | Regra | Categoria | Descrição |
| :-: | :--- | :--- | :--- |
| [**01**](#regra-early-return) | **Early Return** | Fluxo de Controle | Retorno antecipado para evitar aninhamento excessivo de `if`/`else` |
| [**02**](#regra-room-to-breathe) | **Room to Breathe** | Fluxo de Controle | Espaçamento vertical antes de condicionais, loops e retornos |
| [**03**](#regra-sem-numeros-magicos) | **Sem Números Mágicos** | Nomenclatura | Extração de valores numéricos e literais para constantes nomeadas |
| [**04**](#regra-imutabilidade) | **Imutabilidade por Padrão** | Imutabilidade | Uso de `const` e funções puras em vez de `let` mutável em `if`/`else` |
| [**05**](#regra-funcoes-pequenas-srp) | **Funções Pequenas (SRP)** | Complexidade | Funções focadas (≤ 60 linhas, ≤ 4 parâmetros, ciclomática ≤ 12) |
| [**06**](#regra-nomes-descritivos) | **Nomes Descritivos** | Nomenclatura | Nomes que revelam intenção sem abreviações ambíguas (`qty`, `val`) |
| [**07**](#regra-padrao-de-idioma) | **Padrão de Idioma** | Nomenclatura | Inglês por padrão, salvo especificação explícita do projeto |
| [**08**](#regra-comentarios-de-valor) | **Comentários de Valor** | Nomenclatura | Comentários focados no *porquê*, evitando comentar o óbvio |
| [**09**](#regra-comparacao-estrita) | **Comparação Estrita** | Boas Práticas | Uso obrigatório de `===` / `!==` evitando coerção implícita de tipos |
| [**10**](#regra-sem-else-redundante) | **Sem `else` redundante** | Boas Práticas | Eliminação de `else` após blocos com `return` ou `throw` |
| [**11**](#regra-interpolacao-de-strings) | **Interpolação de Strings** | Boas Práticas | Uso de template literals em vez de concatenação manual com `+` |
| [**12**](#regra-sem-ternarios-aninhados) | **Sem Ternários Aninhados** | Boas Práticas | Substituição de ternários aninhados por guard clauses ou funções |
| [**13**](#regra-erros-com-contexto) | **Erros com Contexto** | Tratamento de Erros | Erros com status, mensagem e `cause`, sem engolir exceções |
| [**14**](#regra-separacao-de-camadas) | **Separação de Camadas** | Arquitetura | Regras de negócio desacopladas de frameworks HTTP e banco de dados |
| [**15**](#regra-dry-real) | **DRY Real** | Arquitetura | Reutilização de código apenas quando muda pelo mesmo motivo |
| [**16**](#regra-react-sem-sync-effects) | **React: Sem Sync em Effects** | React | Proibição de copiar props para state dentro de `useEffect` |
| [**17**](#regra-react-efeitos-no-limite) | **React: Efeitos no Limite** | React | `useEffect` reservado para o mundo exterior (DOM, timers, rede) |
| [**18**](#regra-react-deps-completas) | **React: Deps Completas** | React | Array de dependências completo sem omitir referências necessárias |
| [**19**](#regra-codigo-gerado-intocado) | **Código Gerado Intocado** | React | Preservação de arquivos gerados por bibliotecas ou build (`components/ui/`) |
| [**20**](#regra-quality-gate) | **Quality Gate & Disciplina** | Validação | Revisão da diff e execução de testes/linters sem desabilitar regras |

---

<a id="conteudo-detalhado-da-skill"></a>
## 📋 Conteúdo Detalhado da Skill

A skill instrui o agente de IA a seguir rigorosamente as seguintes áreas:

### 1. Fluxo de Controle e Legibilidade
- <a id="regra-early-return"></a>**Early Return:** Uso de retornos e saídas antecipadas em vez de múltiplos níveis de aninhamento com `if`/`else`. ([Exemplos no reference.md ↗](../reference.md#2-functions))
- <a id="regra-room-to-breathe"></a>**Room to Breathe (Espaçamento vertical):** Linha em branco antes de cada `if`, após declarações de variáveis, antes de `return` e ao redor de loops. ([Exemplos no reference.md ↗](../reference.md#5-room-to-breathe-and-explicit-scopes))
- <a id="regra-guard-clauses"></a>**Guard Clauses:** Condicionais de guarda simples permanecem sem chaves apenas quando o corpo é um único `return` ou `throw`. Funções e blocos que realizam trabalho real exigem chaves próprias. ([Exemplos no reference.md ↗](../reference.md#5-room-to-breathe-and-explicit-scopes))

### 2. Nomenclatura e Constantes
- <a id="regra-nomes-descritivos"></a>**Nomes com Intenção Clara:** Nomes descritivos que dizem exatamente o que a variável guarda ou o que a função faz/retorna, sem abreviações ambíguas (`qty`, `tmp`, `val`, `data2`). ([Exemplos no reference.md ↗](../reference.md#1-names-and-intent))
- <a id="regra-sem-numeros-magicos"></a>**Sem Números Mágicos:** Extração de valores numéricos ou strings de configuração para constantes nomeadas (ex: `UPPER_SNAKE_CASE`). ([Exemplos no reference.md ↗](../reference.md#3-constants-vs-magic-numbers))
- <a id="regra-padrao-de-idioma"></a>**Padrão de Idioma:** Escrever código (identificadores, tipos, funções) em **inglês** por padrão, salvo se o projeto especificar obrigatoriamente outro idioma — caso em que o projeto tem precedência; comentários, documentação e logs seguem o padrão e o tom estabelecidos no projeto. ([Exemplos no reference.md ↗](../reference.md#1-names-and-intent))
- <a id="regra-comentarios-de-valor"></a>**Comentários só para o não-óbvio:** Documentação concisa no padrão da linguagem (JSDoc, docstrings) focada no *porquê*, nunca descrevendo o óbvio ou reproduzindo código em texto. ([Exemplos no reference.md ↗](../reference.md#6-comments-only-when-non-obvious))

### 3. Imutabilidade e Escopo
- <a id="regra-imutabilidade"></a>**Imutável por padrão:** Preferência por `const`/`readonly` e funções puras nomeadas em vez de variáveis mutáveis (`let`) reatribuídas dentro de blocos condicionais. ([Exemplos no reference.md ↗](../reference.md#4-immutability--avoid-a-mutable-variable-decided-in-an-ifelse))
- **Mutação restrita:** `let` é reservado apenas quando a mutação é o cerne do algoritmo (como acumuladores dentro de um loop de agregação). ([Exemplos no reference.md ↗](../reference.md#4-immutability--avoid-a-mutable-variable-decided-in-an-ifelse))

### 4. Tamanho de Funções e Complexidade (SRP)
- <a id="regra-funcoes-pequenas-srp"></a>**Responsabilidade Única (SRP):** Cada função deve realizar apenas uma tarefa bem definida. ([Exemplos no reference.md ↗](../reference.md#2-functions))
- **Tamanho visual:** Funções devem caber confortavelmente na tela (~60 linhas). Se exceder, está fazendo mais do que deveria.
- **Métricas limite:**
  - Máximo de **≤ 4 parâmetros** (acima disso, agrupar em objeto/interface).
  - Complexidade ciclomática **≤ 12**.
  - Nível de aninhamento máximo **≤ 3**.

### 5. Boas Práticas Sintáticas
- <a id="regra-comparacao-estrita"></a>**Comparação estrita:** Uso obrigatório de `===` / `!==` (em JS/TS) para evitar coerção implícita de tipos. ([Exemplos no reference.md ↗](../reference.md#7-readability-and-simplicity))
- <a id="regra-interpolacao-de-strings"></a>**Interpolação de Strings:** Uso de template literals (ex: `` `User ${id}` ``) em vez de concatenação com `+`. ([Exemplos no reference.md ↗](../reference.md#7-readability-and-simplicity))
- <a id="regra-sem-else-redundante"></a>**Sem `else` redundante:** Nunca utilizar `else` após um bloco que já encerrou o fluxo com `return` ou `throw`. ([Exemplos no reference.md ↗](../reference.md#2-functions))
- <a id="regra-sem-ternarios-aninhados"></a>**Sem ternários aninhados:** Ternários múltiplos prejudicam a leitura; use guard clauses ou funções auxiliares. ([Exemplos no reference.md ↗](../reference.md#7-readability-and-simplicity))

### 6. Tratamento de Erros Contextualizado
- <a id="regra-erros-com-contexto"></a>**Sem exceções silenciadas:** É proibido capturar erros e ignorá-los silenciosamente (`catch {}` vazio). ([Exemplos no reference.md ↗](../reference.md#9-error-handling))
- **Contexto completo:** Erros propagados ou logados devem conter status, mensagem compreensível e a causa original (`cause`). ([Exemplos no reference.md ↗](../reference.md#9-error-handling))

### 7. Arquitetura e Coesão
- <a id="regra-separacao-de-camadas"></a>**Desacoplamento:** Regras de negócio desacopladas da infraestrutura de entrada/saída (banco de dados, frameworks HTTP, formatações de view). ([Exemplos no reference.md ↗](../reference.md#8-coupling-and-cohesion))
- <a id="regra-dry-real"></a>**DRY Real:** Reutilize código apenas quando ele muda **pela mesma razão**; não unifique lógicas distintas que apenas coincidem por acaso. ([Exemplos no reference.md ↗](../reference.md#8-coupling-and-cohesion))

### 8. Diretrizes Específicas para React
- <a id="regra-react-sem-sync-effects"></a>**Proibição de sincronizar estado via `useEffect`:** Não copie props para `state` dentro de efeitos. Reinicie o ciclo com `key` ou calcule valores derivados diretamente na renderização. ([Exemplos no reference.md ↗](../reference.md#10-react--an-effect-is-not-for-syncing-state))
- <a id="regra-react-efeitos-no-limite"></a>**Efeitos exclusivos para o mundo exterior:** Reservados para conexões de rede, timers, manipulação direta de DOM ou polling. ([Exemplos no reference.md ↗](../reference.md#10-react--an-effect-is-not-for-syncing-state))
- <a id="regra-react-deps-completas"></a>**Array de dependências completo:** Sem omitir dependências intencionalmente; desestruture referências estáveis de hooks (`const { mutateAsync } = useX()`). ([Exemplos no reference.md ↗](../reference.md#10-react--an-effect-is-not-for-syncing-state))
- <a id="regra-codigo-gerado-intocado"></a>**Código gerado/vendored intocado:** Não editar manualmente arquivos gerados (como `shadcn/ui`, Prisma clients ou bundles em `dist/`). ([Exemplos no reference.md ↗](../reference.md#10-react--an-effect-is-not-for-syncing-state))

### 9. Portão de Validação e Qualidade
- <a id="regra-quality-gate"></a>**Revisão ativa da diff:** O agente deve checar as alterações linha a linha contra o checklist antes de declarar a tarefa pronta. ([Exemplos no reference.md ↗](../reference.md#12-human-judgment-not-mechanizable))
- **Execução do Quality Gate do projeto:** Rodar testes e checagens estáticas configuradas no repositório (`yarn lint:check`, `npm test`, `pytest`, `tsc`). ([Exemplos no reference.md ↗](../reference.md#11-boy-scout-rule))
- **Proibido burlar linters:** Nunca desabilitar regras de linter para fazer a CI passar; corrija a causa raiz.

---

<a id="como-os-agentes-de-ia-utilizam-esta-skill"></a>
## 🤖 Como os Agentes de IA Utilizam esta Skill

A skill é definida segundo o padrão de especificações do Claude Code / OpenCode:

1. **Descoberta Automática:** O arquivo `SKILL.md` contém o cabeçalho YAML com `name: clean-code` e uma descrição semântica dos momentos em que deve ser utilizada.
2. **Ativação Autônoma:** Quando o usuário pede para criar, editar, refatorar código ou abrir pull requests, o agente carrega a skill proativamente e aplica suas regras.
3. **Invocação Direta:** O usuário pode a qualquer momento reforçar o uso da skill solicitando diretamente (ex: *"Revise este arquivo seguindo a skill clean-code"*).
4. **Consulta ao Guia:** Se surgir dúvida sobre como estruturar determinado padrão, o agente consulta os exemplos práticos em `reference.md`.

---

<a id="licenca"></a>
## 📄 Licença

Distribuído sob a licença MIT. Sinta-se livre para utilizar, customizar e estender para seus projetos pessoais ou corporativos.
