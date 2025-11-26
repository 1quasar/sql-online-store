-- 500 товаров, распределённых по популярным категориям
INSERT INTO core.products (product_name, sku, category_id, price)
SELECT
  'Товар_' || g::text,
  'SKU-'   || g::text,
  ((g - 1) % 5) + 1,                                  -- 5 категорий
  (random() * 9000 + 500)::numeric(12,2)              -- цены 500–9500₽
FROM generate_series(1, 500) AS g;
