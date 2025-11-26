-- дневная выручка и накопительный итог
WITH daily AS (
  SELECT
    date_trunc('day', o.order_date) AS day,
    SUM(oi.quantity * oi.price)     AS revenue_rub,
    COUNT(DISTINCT o.order_id)      AS orders_count
  FROM core.orders o
  JOIN core.order_items oi ON oi.order_id = o.order_id
  GROUP BY date_trunc('day', o.order_date)
)
SELECT
  day,
  revenue_rub,
  orders_count,
  SUM(revenue_rub) OVER (ORDER BY day) AS cumulative_revenue
FROM daily
ORDER BY day;
