# Логическая модель

## Таблицы

- `core.traffic_sources`
  - `source_id` PK
  - `source_name`
  - `channel`

- `core.customers`
  - `customer_id` PK
  - `first_name`
  - `last_name`
  - `email` (UNIQUE)
  - `source_id` FK - traffic_sources.source_id

- `core.categories`
  - `category_id` PK
  - `category_name`
  - `parent_category_id` FK - categories.category_id (nullable)

- `core.products`
  - `product_id` PK
  - `category_id` FK - categories.category_id
  - `product_name`
  - `sku` (UNIQUE)
  - `price`

- `core.orders`
  - `order_id` PK
  - `customer_id` FK - customers.customer_id
  - `order_date`
  - `status`

- `core.order_items`
  - `order_item_id` PK
  - `order_id` FK - orders.order_id
  - `product_id` FK - products.product_id
  - `quantity`
  - `price` (фикс цены на момент заказа)

- `core.payments`
  - `payment_id` PK
  - `order_id` FK - orders.order_id
  - `amount`
  - `paid_at`
  - `method`
  - `status`

- `core.shipments`
  - `shipment_id` PK
  - `order_id` FK - orders.order_id
  - `shipped_at`
  - `delivered_at`
  - `city`
  - `country`
  - `status`
