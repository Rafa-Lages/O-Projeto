-- Estrutura inicial do Projeto: roteador, log de mensagens e lembretes.

-- Tabela de comandos: prefixo -> módulo (irmão) que atende.
create table public.comandos (
  prefixo     text primary key,              -- ex.: 'PR', 'AG', 'LB'
  modulo      text not null,                 -- ex.: 'financeiro', 'agenda', 'lembretes'
  descricao   text,
  ativo       boolean not null default true,
  criado_em   timestamptz not null default now()
);

insert into public.comandos (prefixo, modulo, descricao) values
  ('PR', 'financeiro', 'Lançamento de gasto na planilha'),
  ('AG', 'agenda',     'Compromisso no Google Agenda'),
  ('LB', 'lembretes',  'Lembrete no painel de atividades');

-- Log de todas as mensagens recebidas e enviadas.
create table public.mensagens (
  id            bigint generated always as identity primary key,
  direcao       text not null check (direcao in ('entrada', 'saida')),
  telefone      text not null,
  texto         text,
  prefixo       text references public.comandos (prefixo),
  modulo        text,
  wa_message_id text unique,                 -- id da Meta, evita processar duplicado
  status        text not null default 'recebida',
  erro          text,
  criado_em     timestamptz not null default now()
);

create index mensagens_criado_em_idx on public.mensagens (criado_em desc);

-- Lembretes e atividades exibidos no painel do claude.ai.
create table public.lembretes (
  id            bigint generated always as identity primary key,
  titulo        text not null,
  detalhes      text,
  vence_em      timestamptz,
  concluido     boolean not null default false,
  concluido_em  timestamptz,
  origem        text not null default 'whatsapp' check (origem in ('whatsapp', 'painel')),
  mensagem_id   bigint references public.mensagens (id),
  criado_em     timestamptz not null default now()
);

create index lembretes_pendentes_idx on public.lembretes (vence_em) where not concluido;

-- Segurança: RLS ligado e nenhuma política pública.
-- Só as Edge Functions (service role) e o dono do projeto acessam.
alter table public.comandos  enable row level security;
alter table public.mensagens enable row level security;
alter table public.lembretes enable row level security;
