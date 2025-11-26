# Концептуальная модель

Сущности:
- **Customer** — клиент интернет-магазина.
- **Order** — заказ.
- **OrderItem** — отдельная позиция в заказе.
- **Product** — товар.
- **Category** — категория товара.
- **Payment** — оплата заказа.
- **Shipment** — доставка заказа.
- **TrafficSource** — источник трафика/привлечения клиента.

Связи:
- Один Customer может сделать много Orders.
- Один Order может содержать много OrderItems.
- Один Product может входить в много OrderItems.
- Один Product относится к одной Category, у Category может быть родительская Category (иерархия).
- У каждого Order есть одна Payment и одна Shipment.
- Каждый Customer пришёл из какого-то TrafficSource.
