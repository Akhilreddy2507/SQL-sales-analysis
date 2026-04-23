-- 1. Total revenue by product
SELECT
    p.product_name,
    ROUND(SUM(o.quantity * p.unit_price), 2) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 2. Monthly sales trend
SELECT
    DATE_TRUNC('month', o.order_date) AS sales_month,
    ROUND(SUM(o.quantity * p.unit_price), 2) AS monthly_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY sales_month;

-- 3. Top customers by revenue
SELECT
    c.customer_name,
    ROUND(SUM(o.quantity * p.unit_price), 2) AS customer_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY customer_revenue DESC;

-- 4. Rank products by revenue using a window function
WITH product_revenue AS (
    SELECT
        p.product_name,
        ROUND(SUM(o.quantity * p.unit_price), 2) AS total_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM product_revenue;

-- 5. Customers with total revenue above 100
SELECT
    c.customer_name,
    ROUND(SUM(o.quantity * p.unit_price), 2) AS customer_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING SUM(o.quantity * p.unit_price) > 100
ORDER BY customer_revenue DESC;
