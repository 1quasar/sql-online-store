-- около 15000 заказов
INSERT INTO core.orders (customer_id, order_date, status)
SELECT
  (random() * 4999 + 1)::int,
  now() - (random() * interval '120 days'),
  (ARRAY['created','paid','shipped','cancelled'])[(random()*3)::int + 1]
FROM generate_series(1, 15000);

-- для каждого заказа создаём 1–5 строк order_items
INSERT INTO core.order_items (order_id, product_id, quantity, price)
SELECT
  o.order_id,
  (random() * 499 + 1)::int AS product_id,
  (random() * 4 + 1)::int AS quantity,
  p.price
FROM core.orders o
JOIN LATERAL (
  SELECT price
  FROM core.products
  WHERE product_id = (random() * 499 + 1)::int
  LIMIT 1
) p ON TRUE
JOIN generate_series(1, (random()*4 + 1)::int) AS s ON TRUE;


INSERT INTO core.payments (order_id, amount, paid_at, method, status)
SELECT
  o.order_id,
  SUM(oi.quantity * oi.price) AS amount,
  o.order_date + (random() * interval '1 day') AS paid_at,
  (ARRAY['card','cash'])[(random()*1)::int + 1] AS method,
  CASE WHEN o.status = 'cancelled' THEN 'failed' ELSE 'paid' END
FROM core.orders o
JOIN core.order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.order_date, o.status;

INSERT INTO core.shipments (order_id, shipped_at, delivered_at, city, country, status)
SELECT
  o.order_id,
  CASE WHEN o.status IN ('paid','shipped')
       THEN o.order_date + (random() * interval '2 days')
  END AS shipped_at,
  CASE WHEN o.status = 'shipped'
       THEN o.order_date + (random() * interval '7 days')
  END AS delivered_at,
  (ARRAY['Москва','Санкт-Петербург','Казань','Новосибирск', 'Сочи'])[(random()*3)::int + 1],
  'Россия',
  CASE 
    WHEN o.status = 'shipped' THEN 'delivered'
    WHEN o.status = 'paid' THEN 'processing'
    WHEN o.status = 'cancelled' THEN 'cancelled'
    ELSE 'new'
  END AS status
FROM core.orders o;

