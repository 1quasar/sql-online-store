# Физическая модель

- Идентификаторы: `BIGINT GENERATED ALWAYS AS IDENTITY` (запас по объёму).
- Денежные значения: `NUMERIC(12,2)`.
- Даты и время: `TIMESTAMPTZ`.
- Строки: `VARCHAR`.
- Флаги: `BOOLEAN`.

Индексация:
- Индексы на все внешние ключи (`customer_id`, `product_id`, `order_id`, `source_id`).
- Отдельный индекс на `orders(order_date)` для аналитики по датам.
- Составной индекс `orders(customer_id, order_date)` для выборок истории клиента.
