-- делаем email клиента уникальным, чтобы не было двух клиентов с одним email
ALTER TABLE core.customers
  ADD CONSTRAINT uq_customers_email UNIQUE (email);

-- артикул товара (sku) тоже должен быть уникальным
ALTER TABLE core.products
  ADD CONSTRAINT uq_products_sku UNIQUE (sku);

-- customers.source_id ссылается на traffic_sources.source_id
ALTER TABLE core.customers
  ADD CONSTRAINT fk_customers_source
  FOREIGN KEY (source_id) REFERENCES core.traffic_sources(source_id);

-- иерархия категорий: category.parent_category_id - categories.category_id
ALTER TABLE core.categories
  ADD CONSTRAINT fk_categories_parent
  FOREIGN KEY (parent_category_id) REFERENCES core.categories(category_id);

-- товар относится к категории
ALTER TABLE core.products
  ADD CONSTRAINT fk_products_category
  FOREIGN KEY (category_id) REFERENCES core.categories(category_id);

-- заказ относится к клиенту
ALTER TABLE core.orders
  ADD CONSTRAINT fk_orders_customer
  FOREIGN KEY (customer_id) REFERENCES core.customers(customer_id);

-- позиция заказа относится к заказу
ALTER TABLE core.order_items
  ADD CONSTRAINT fk_order_items_order
  FOREIGN KEY (order_id) REFERENCES core.orders(order_id);

-- позиция заказа относится к товару
ALTER TABLE core.order_items
  ADD CONSTRAINT fk_order_items_product
  FOREIGN KEY (product_id) REFERENCES core.products(product_id);

-- платеж относится к заказу
ALTER TABLE core.payments
  ADD CONSTRAINT fk_payments_order
  FOREIGN KEY (order_id) REFERENCES core.orders(order_id);

-- доставка относится к заказу
ALTER TABLE core.shipments
  ADD CONSTRAINT fk_shipments_order
  FOREIGN KEY (order_id) REFERENCES core.orders(order_id);

-- ускоряем выборки по источнику трафика
CREATE INDEX idx_customers_source
  ON core.customers(source_id);

-- часто будем искать заказы по клиенту
CREATE INDEX idx_orders_customer
  ON core.orders(customer_id);

-- и по дате заказа
CREATE INDEX idx_orders_date
  ON core.orders(order_date);

-- быстрые join заказ - позиции
CREATE INDEX idx_order_items_order
  ON core.order_items(order_id);

-- быстрые выборки по товару
CREATE INDEX idx_order_items_product
  ON core.order_items(product_id);

CREATE INDEX idx_payments_order
  ON core.payments(order_id);

CREATE INDEX idx_shipments_order
  ON core.shipments(order_id);
