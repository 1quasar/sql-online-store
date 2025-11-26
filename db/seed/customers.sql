-- генерация 5000 клиентов
INSERT INTO core.customers (first_name, last_name, email, phone, source_id, registered_at)
SELECT
  'Имя_' || g::text,
  'Фамилия_' || g::text,
  'user' || g::text || '@mail.ru',
  '+79' || LPAD(g::text, 9, '0'),                    -- РФ номер
  (random() * 5 + 1)::int,                           -- 1..6 источников
  now() - (random() * interval '365 days')
FROM generate_series(1, 5000) AS g;
