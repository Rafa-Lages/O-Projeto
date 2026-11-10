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

## Roteiro do MVP
1. [x] Repositório e CLAUDE.md
2. [ ] Projeto Supabase e tabelas (`comandos`, `mensagens`, `lembretes`)
3. [ ] App da Meta e número de teste do WhatsApp
4. [ ] Webhook + roteador respondendo "eco"
5. [ ] Comando PR gravando na planilha
6. [ ] Comando AG no Google Agenda
7. [ ] Comando LB + painel de lembretes

## Pendências
- Projeto Supabase: o free permite 2 ativos e já existem 2. Pausar um ou reaproveitar.
- Interpretação das mensagens: formato fixo ou IA gratuita.
