-- источники трафика: откуда пришли пользователи
CREATE TABLE core.traffic_sources (
    source_id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_name VARCHAR(100) NOT NULL,
    channel     VARCHAR(50)  NOT NULL
);

-- клиенты интернет-магазина
CREATE TABLE core.customers (
    customer_id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- уникальный id клиента
    first_name    VARCHAR(100) NOT NULL,  -- имя
    last_name     VARCHAR(100),           -- фамилия (может быть пустой)
    email         VARCHAR(255) NOT NULL,  -- уникальный
    phone         VARCHAR(30),            -- необязательный телефон
    registered_at TIMESTAMPTZ  NOT NULL DEFAULT now(), -- когда зарегистрировался
    source_id     BIGINT,                 -- откуда пришёл (FK на traffic_sources)
    is_active     BOOLEAN      NOT NULL DEFAULT TRUE,   -- активен/заблокирован
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),  -- когда записали в систему
    updated_at    TIMESTAMPTZ  NOT NULL DEFAULT now()   -- когда последний раз меняли
);

-- категории товаров, с поддержкой иерархии
CREATE TABLE core.categories (
    category_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name      VARCHAR(100) NOT NULL, -- "Электроника", "Одежда" и т.п.
    parent_category_id BIGINT                -- если NULL — это корневая категория
);

-- товары, которые продаём
CREATE TABLE core.products (
    product_id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(200)      NOT NULL, -- название товара
    sku          VARCHAR(100)      NOT NULL, -- артикул UNIQUE
    category_id  BIGINT            NOT NULL, -- ссылка на категорию
    price        NUMERIC(12,2)     NOT NULL, -- текущая цена
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT now(),
    updated_at   TIMESTAMPTZ       NOT NULL DEFAULT now()
);

-- заказы, которые делают клиенты
CREATE TABLE core.orders (
    order_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id  BIGINT            NOT NULL, -- кто сделал заказ
    order_date   TIMESTAMPTZ       NOT NULL, -- когда заказ был создан
    status       VARCHAR(30)       NOT NULL, -- created/paid/shipped/cancelled
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT now()
);

-- отдельные позиции внутри заказа
CREATE TABLE core.order_items (
    order_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id      BIGINT       NOT NULL,        -- к какому заказу относится
    product_id    BIGINT       NOT NULL,        -- какой товар
    quantity      INTEGER      NOT NULL CHECK (quantity > 0), -- количество > 0
    price         NUMERIC(12,2) NOT NULL        -- цена товара на момент заказа
);

-- оплаты заказов
CREATE TABLE core.payments (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id   BIGINT        NOT NULL,        -- какой заказ оплачиваем
    amount     NUMERIC(12,2) NOT NULL,        -- сумма
    paid_at    TIMESTAMPTZ,                   -- когда платёж прошёл
    method     VARCHAR(30)   NOT NULL,        -- способ оплаты: card/cash
    status     VARCHAR(30)   NOT NULL         -- статус: paid/failed/etc
);

-- доставки заказов
CREATE TABLE core.shipments (
    shipment_id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id      BIGINT       NOT NULL,      -- какой заказ доставляем
    shipped_at    TIMESTAMPTZ,                -- когда отправили
    delivered_at  TIMESTAMPTZ,                -- когда доставили
    city          VARCHAR(100),               -- город доставки
    country       VARCHAR(100),               -- страна
    status        VARCHAR(30)  NOT NULL       -- статус доставки
);


