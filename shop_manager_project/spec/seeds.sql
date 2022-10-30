TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO "public"."items" ("id", "item", "price", "stock") VALUES
(1, 'Bread', 135, 50),
(2, 'Milk', 90, 40),
(3, 'Coffee', 300, 30),
(4, 'Sugar', 500, 20),
(5, 'Banana', 60, 10),
(6, 'Butter', 200, 15),
(7, 'Tea', 350, 12);

INSERT INTO "public"."orders" ("id", "name", "date") VALUES
(1, 'Susan', '2022-01-01'),
(2, 'Sam', '2022-01-02'),
(3, 'Joe', '2022-01-03'),
(4, 'Greg', '2022-01-04');

INSERT INTO "public"."items_orders" ("item_id", "order_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4);