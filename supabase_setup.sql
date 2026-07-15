-- ПЕРВИЧНАЯ УСТАНОВКА (уже выполнено один раз для проекта dgmzlgjvgkomxjvgtyga).
-- Оставлено для справки / для настройки нового проекта Supabase с нуля.

create table public.submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  site text,
  session_id uuid,
  stage text,
  lang text,
  category text,
  pattern_title text,
  name text,
  phone text,
  problem_text text,
  duration text,
  situation_text text,
  emotions text,
  answers jsonb
);

alter table public.submissions enable row level security;

-- Разрешаем анонимным посетителям сайта ТОЛЬКО добавлять записи (не читать и не менять чужие данные)
create policy "Allow public inserts"
  on public.submissions
  for insert
  to anon
  with check (true);

-- Читать записи сможете только вы: Supabase Dashboard -> Table Editor -> submissions.


-- ==========================================================================
-- МИГРАЦИЯ: выполните это в SQL Editor, если таблица submissions уже создана
-- по старой версии скрипта (без колонок site/session_id/stage/answers).
-- ==========================================================================

alter table public.submissions
  add column if not exists site text,
  add column if not exists session_id uuid,
  add column if not exists stage text,
  add column if not exists answers jsonb;


-- ==========================================================================
-- ВТОРОЙ САЙТ: когда будете подключать новый сайт к той же базе, используйте
-- тот же Project URL и anon key, но в коде нового сайта задайте другой SITE_ID
-- (например 'site-2'), чтобы отличать заявки по колонке site.
-- Таблицу и SQL выше повторно создавать не нужно.
-- ==========================================================================
