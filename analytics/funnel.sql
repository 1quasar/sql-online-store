-- воронка
WITH base AS (
  SELECT
    date_trunc('day', order_date) AS day,
    COUNT(*) FILTER (WHERE status IN ('created','paid','shipped','cancelled')) AS created_cnt,
    COUNT(*) FILTER (WHERE status IN ('paid','shipped')) AS paid_cnt,
    COUNT(*) FILTER (WHERE status = 'shipped') AS shipped_cnt
  FROM core.orders
  GROUP BY date_trunc('day', order_date)
)
SELECT
  day,
  created_cnt,
  paid_cnt,
  shipped_cnt,
  ROUND(paid_cnt::numeric   / NULLIF(created_cnt,0) * 100, 1) AS conv_created_to_paid,
  ROUND(shipped_cnt::numeric / NULLIF(paid_cnt,0) * 100, 1)   AS conv_paid_to_shipped
FROM base
ORDER BY day;
