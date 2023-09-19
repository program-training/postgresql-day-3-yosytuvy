-- PART 1
-- 1

SELECT employees.first_name ||' '|| employees.last_name AS employee_name,
COUNT(orders.employee_id) AS number_of_orders
FROM employees INNER JOIN orders
ON employees.employee_id = orders.employee_id
GROUP BY employees.first_name, employees.last_name;


-- 2
SELECT categories.category_name,
SUM(order_details.unit_price * order_details.quantity * (1-order_details.discount))
AS sum_of_sales
FROM order_details INNER JOIN products
ON order_details.product_id = products.product_id
INNER JOIN categories
ON products.category_id = categories.category_id
GROUP BY categories.category_id
ORDER BY sum_of_sales DESC;


-- 3
SELECT customers.company_name, AVG(
    (order_details.unit_price * order_details.quantity * (1-order_details.discount))
) AS average_price
FROM orders INNER JOIN order_details
ON order_details.order_id = orders.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
GROUP BY customers.company_name
ORDER BY average_price DESC;


-- 4
SELECT customers.company_name, SUM(
    (order_details.unit_price * order_details.quantity * (1-order_details.discount))
) AS total_spend
FROM orders INNER JOIN order_details
ON order_details.order_id = orders.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
GROUP BY customers.company_name
ORDER BY total_spend DESC
LIMIT 10;


-- 5
SELECT EXTRACT(MONTH FROM orders.order_date) AS month,
SUM(
    (order_details.unit_price * order_details.quantity * (1-order_details.discount))
) AS total_sales
FROM orders INNER JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY month
ORDER BY month;


-- 6
SELECT product_name, units_in_stock FROM products
WHERE units_in_stock < 10;


-- 7
SELECT customers.company_name,
    (order_details.unit_price * order_details.quantity * (1-order_details.discount))
AS total_order
FROM orders INNER JOIN  order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY total_order DESC
LIMIT 1;


-- 8
SELECT orders.ship_country, SUM(
    (order_details.unit_price * order_details.quantity * (1-order_details.discount))
) AS total_sales
FROM orders INNER JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY ship_country
ORDER BY total_sales;


-- 9
SELECT shippers.company_name, COUNT(orders.order_id) AS number_of_orders
FROM orders INNER JOIN shippers
ON orders.ship_via = shippers.shipper_id
GROUP BY orders.ship_via, shippers.company_name
ORDER BY number_of_orders DESC
LIMIT 1;


-- 10
SELECT products.product_name
FROM products LEFT OUTER JOIN order_details
ON products.product_id = order_details.product_id
WHERE order_details.product_id = NULL;