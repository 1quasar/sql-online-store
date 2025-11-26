-- источники трафика
INSERT INTO core.traffic_sources (source_name, channel)
VALUES
  ('Ozon',            'marketplace'),
  ('Wildberries',     'marketplace'),
  ('Yandex Market',   'marketplace'),
  ('VK Ads',          'social'),
  ('Telegram',        'social'),
  ('Email Newsletter','email');

-- категории
INSERT INTO core.categories (category_name)
VALUES
  ('Электроника'),
  ('Одежда и обувь'),
  ('Дом и дача'),
  ('Книги'),
  ('Детские товары');
