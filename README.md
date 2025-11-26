## Структура проекта

sql-online-store/
├── docs/ # документация по модели данных
│ ├── conceptual.md
│ ├── logical.md
│ └── physical.md
│
├── db/
│ ├── migrations/ # схемы, таблицы, связи, витрины
│ │ ├── schemas.sql
│ │ ├── tables.sql
│ │ ├── constraints_indexes.sql
│ │ └── views.sql
│ │
│ └── seed/ # заполнение базы тестовыми данными
│ ├── refs.sql
│ ├── customers.sql
│ ├── products.sql
│ └── orders_items.sql
│
├── analytics/ # аналитические запросы
│ ├── daily_revenue.sql
│ ├── funnel.sql
│ ├── rfm.sql
│ └── cohorts.sql
│
└── README.md

## О проекте
Мини-датастор для интернет-магазина
- клиенты с источниками привлечения,
- товары и категории,
- заказы и позиции заказов,
- оплаты банковской картой или наличными,
- доставки по городам РФ.

## Как запустить
### 1. Создание базы
```sql
CREATE DATABASE online_store;
```

### 2. Выполнение миграции
db/migrations/schemas.sql
db/migrations/tables.sql
db/migrations/constraints_indexes.sql
db/migrations/views.sql

### 3. Заполнение базы данных
db/seed/001_refs.sql
db/seed/010_customers.sql
db/seed/020_products.sql
db/seed/030_orders_items.sql

## Аналитика

### Дневная выручка  
`analytics/daily_revenue.sql`  
- выручка по дням,  
- количество заказов,  
- накопительная выручку.

---

### Воронка заказов  
`analytics/funnel.sql`  

---

### RFM-анализ  
`analytics/rfm.sql`  
Метрики:
- **Recency** — когда был последний заказ,  
- **Frequency** — сколько заказов сделал клиент,  
- **Monetary** — сколько денег он принес.  

---

### Когортный анализ  
`analytics/cohorts.sql`  
Группировка клиентов по месяцу их первой покупки и наблюдение, как они продолжают покупать по месяцам.

---

## Документация модели

В папке `docs/` находятся:

### `conceptual.md`  
Описание сущностей интернет-магазина и связей между ними.

### `logical.md`  
Таблицы, ключи, связи — логическое представление будущей структуры БД.

### `physical.md`  
Типы данных, индексы, ограничения и логика.

