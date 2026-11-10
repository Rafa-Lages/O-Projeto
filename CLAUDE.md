# O Projeto — instruções para o Claude

Este repositório é a infraestrutura do assistente pessoal do Rafael no WhatsApp.
O agente responsável pela infraestrutura se chama **Adão**. Outros agentes (os "irmãos": Financeiro, Operações, Agenda...) serão plugados como módulos.

Responda sempre em **português do Brasil**.

## Premissas (não mudar sem conversar com o Rafael)
- **Custo zero** no MVP. Antes de propor qualquer serviço, confirme que há plano gratuito.
- **Canal:** WhatsApp Cloud API oficial da Meta. Só responder dentro da janela de 24h aberta pelo usuário. Não enviar templates (são pagos).
- **Execução:** Supabase (Edge Functions em Deno/TypeScript + Postgres). Projeto `o-projeto`, ref `uezogedvjgwjebxwfjbm`.
- **Financeiro:** Google Sheets. **Agenda:** Google Calendar.
- **Lembretes:** tabela `lembretes` no Supabase, exibida num artefato do claude.ai (não usamos Notion).

## Arquitetura
WhatsApp → `whatsapp-webhook` (Edge Function) → roteador → módulo → integração → resposta no WhatsApp.

- O roteador consulta a tabela `comandos` (prefixo → módulo).
- Cada irmão é um módulo isolado em `supabase/functions/_modulos/<nome>/`.
- Adicionar um irmão = criar o módulo + inserir uma linha em `comandos`. Não alterar o webhook nem o roteador para isso.
- Toda mensagem recebida e enviada é registrada na tabela `mensagens`.

## Comandos planejados
| Prefixo | Módulo | Exemplo |
|---|---|---|
| PR | financeiro | `PR, comprei um sanduíche hoje por R$50` |
| AG | agenda | `AG reunião amanhã 15h` |
| LB | lembretes | `LB pagar a conta de luz sexta` |

## Estrutura
```
docs/                     decisões e arquitetura
supabase/migrations/      SQL versionado do banco
supabase/functions/       Edge Functions
```

## Regras de trabalho
- Segredos (tokens da Meta, Google, etc.) ficam só nos secrets do Supabase. Nunca no código nem no Git.
- Mudanças no banco sempre via arquivo em `supabase/migrations/`.
- Commits pequenos, mensagens em português.
- Decisões novas vão para `docs/arquitetura.md`.
