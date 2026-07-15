-- Выполните этот SQL один раз в Supabase: Dashboard -> SQL Editor -> New query -> Run

create table public.submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  lang text,
  category text,
  pattern_title text,
  name text,
  phone text,
  problem_text text,
  duration text,
  situation_text text,
  emotions text
);

alter table public.submissions enable row level security;

-- Разрешаем анонимным посетителям сайта ТОЛЬКО добавлять записи (не читать чужие данные)
create policy "Allow public inserts"
  on public.submissions
  for insert
  to anon
  with check (true);

-- Читать записи сможете только вы, в дашборде Supabase (Table Editor) или через service_role key.
