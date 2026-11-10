# Arquitetura e premissas

## Premissas (10/11/2026)
1. Custo zero no MVP.
2. Canal: WhatsApp Cloud API oficial. Respostas na janela de 24h aberta pelo usuário (1.000 grátis/mês por número). Mensagens iniciadas pelo assistente exigem template pago, então ficam fora do MVP.
3. Lembretes: painel em artefato no claude.ai, lendo a tabela `lembretes` do Supabase (substitui o Notion).
4. Financeiro: Google Sheets.
5. Agenda: Google Calendar.
6. Código: este repositório, desenvolvido com Claude Code.
7. Execução: Supabase free (Edge Functions + Postgres).

## Fluxo
WhatsApp → webhook → roteador (tabela `comandos`) → módulo do irmão → Sheets / Calendar / `lembretes` → resposta no WhatsApp.

## Supabase
- Projeto: `o-projeto` (ref `uezogedvjgwjebxwfjbm`), região São Paulo (sa-east-1), plano free.
- Para liberar a vaga, o projeto `eventfoto` foi pausado em 10/11/2026 (restaurável com um clique até 08/02/2027).
- RLS ligado em todas as tabelas, sem políticas públicas: só Edge Functions (service role) acessam.

## Roteiro do MVP
1. [x] Repositório e CLAUDE.md
2. [x] Projeto Supabase e tabelas (`comandos`, `mensagens`, `lembretes`)
3. [ ] App da Meta e número de teste do WhatsApp
4. [ ] Webhook + roteador respondendo "eco"
5. [ ] Comando PR gravando na planilha
6. [ ] Comando AG no Google Agenda
7. [ ] Comando LB + painel de lembretes

## Pendências
- Interpretação das mensagens: formato fixo ou IA gratuita.
