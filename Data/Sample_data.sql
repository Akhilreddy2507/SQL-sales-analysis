INSERT INTO customers (customer_id, customer_name, state) VALUES
(1, 'Alice', 'Texas'),
(2, 'Bob', 'California'),
(3, 'Charlie', 'Texas'),
(4, 'Diana', 'New York');

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(101, 'Keyboard', 'Accessories', 45.50),
(102, 'Mouse', 'Accessories', 18.25),
(103, 'Monitor', 'Displays', 155.00);

INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity) VALUES
(1001, 1, 101, '2025-01-03', 2),
(1002, 2, 102, '2025-01-04', 1),
(1003, 1, 103, '2025-01-06', 1),
(1004, 3, 103, '2025-02-01', 2),
(1005, 4, 101, '2025-02-05', 1),
(1006, 2, 102, '2025-02-08', 3);
