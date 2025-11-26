-- когорты по месяцу первого заказа и активность по месяцам

-- для каждого клиента дата первого заказа
WITH first_order AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order_date
  FROM core.orders
  GROUP BY customer_id
),

-- к каждому заказу присоединяем когортный месяц
orders_with_cohort AS (
  SELECT
    o.customer_id,
    date_trunc('month', fo.first_order_date) AS cohort_month, -- месяц первой покупки
    date_trunc('month', o.order_date)        AS order_month   -- месяц конкретного заказа
  FROM core.orders o
  JOIN first_order fo ON fo.customer_id = o.customer_id
),

-- сколько уникальных клиентов из когорты покупало в каждый месяц
cohort_stats AS (
  SELECT
    cohort_month,
    order_month,
    COUNT(DISTINCT customer_id) AS active_customers
  FROM orders_with_cohort
  GROUP BY cohort_month, order_month
)
SELECT
  cohort_month,
  order_month,
  active_customers
FROM cohort_stats
ORDER BY cohort_month, order_month;
