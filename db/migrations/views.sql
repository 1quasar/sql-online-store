-- витрина: дневная выручка и количество заказов
CREATE VIEW marts.daily_revenue AS
SELECT
  date_trunc('day', o.order_date) AS day,     -- обрезаем до дня
  SUM(oi.quantity * oi.price)     AS revenue, -- суммарная выручка за день
  COUNT(DISTINCT o.order_id)      AS orders_count -- количество уникальных заказов
FROM core.orders o
JOIN core.order_items oi ON oi.order_id = o.order_id
GROUP BY date_trunc('day', o.order_date);

-- витрина: выручка по дню и источникам трафика
CREATE VIEW marts.daily_revenue_by_source AS
SELECT
  date_trunc('day', o.order_date)        AS day,
  ts.channel,                             -- канал
  ts.source_name,                         -- конкретный источник
  SUM(oi.quantity * oi.price)            AS revenue,
  COUNT(DISTINCT o.order_id)             AS orders_count
FROM core.orders o
JOIN core.order_items oi ON oi.order_id = o.order_id
JOIN core.customers c ON c.customer_id = o.customer_id
LEFT JOIN core.traffic_sources ts ON ts.source_id = c.source_id
GROUP BY date_trunc('day', o.order_date), ts.channel, ts.source_name;
