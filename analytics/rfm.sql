-- RFM-анализ

-- агрегаты по клиентам
WITH orders_by_customer AS (
  SELECT
    c.customer_id,
    MAX(o.order_date)                      AS last_order_date,            -- последняя покупка
    COUNT(DISTINCT o.order_id)             AS frequency,                  -- сколько заказов
    SUM(oi.quantity * oi.price)            AS monetary                    -- сколько денег принёс
  FROM core.customers c
  JOIN core.orders o ON o.customer_id = c.customer_id
  JOIN core.order_items oi ON oi.order_id = o.order_id
  GROUP BY c.customer_id
),

-- 5 квантилей по каждому измерению
scores AS (
  SELECT
    customer_id,
    last_order_date,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY last_order_date DESC) AS r_score, -- Recency: чем новее покупка, тем выше балл
    NTILE(5) OVER (ORDER BY frequency)            AS f_score, -- Frequency: чаще покупает - выше
    NTILE(5) OVER (ORDER BY monetary)             AS m_score  -- Monetary: больше денег - выше
  FROM orders_by_customer
)
SELECT
  customer_id,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS rfm_score     -- суммарный RFM-скор
FROM scores
ORDER BY rfm_score DESC;
