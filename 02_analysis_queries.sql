-- =========================================================
-- SUPERSTORE SALES ANALYSIS - MySQL Project
-- Part 2: Analysis / Business Insight Queries
-- Run 01_schema_and_data.sql first.
-- =========================================================
USE superstore_db;

-- 1. Total Sales, Profit, and Order Count overview
SELECT
    COUNT(DISTINCT o.order_id)   AS total_orders,
    COUNT(*)                     AS total_line_items,
    ROUND(SUM(od.sales), 2)      AS total_sales,
    ROUND(SUM(od.profit), 2)     AS total_profit,
    ROUND(SUM(od.profit)/SUM(od.sales) * 100, 2) AS profit_margin_pct
FROM order_details od
JOIN orders o ON o.order_id = od.order_id;

-- 2. Sales & Profit by Category
SELECT
    p.category,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit,
    SUM(od.quantity)         AS total_quantity
FROM order_details od
JOIN products p ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 3. Sales & Profit by Sub-Category (Top 10 by Sales)
SELECT
    p.category,
    p.sub_category,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit
FROM order_details od
JOIN products p ON p.product_id = od.product_id
GROUP BY p.category, p.sub_category
ORDER BY total_sales DESC
LIMIT 10;

-- 4. Regional performance (Sales, Profit, Regional Manager)
SELECT
    c.region,
    rm.person AS regional_manager,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit,
    COUNT(DISTINCT o.order_id) AS orders_count
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id
LEFT JOIN regional_managers rm ON rm.region = c.region
GROUP BY c.region, rm.person
ORDER BY total_sales DESC;

-- 5. Top 10 Customers by total spend
SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    COUNT(DISTINCT o.order_id) AS orders_count
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.segment
ORDER BY total_sales DESC
LIMIT 10;

-- 6. Monthly Sales Trend
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
GROUP BY order_month
ORDER BY order_month;

-- 7. Ship Mode usage and average delivery time (days)
SELECT
    o.ship_mode,
    COUNT(*) AS order_count,
    ROUND(AVG(DATEDIFF(o.ship_date, o.order_date)), 1) AS avg_ship_days
FROM orders o
GROUP BY o.ship_mode
ORDER BY order_count DESC;

-- 8. Products that are loss-making (negative profit), worst 10
SELECT
    p.product_name,
    p.category,
    p.sub_category,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit
FROM order_details od
JOIN products p ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name, p.category, p.sub_category
HAVING total_profit < 0
ORDER BY total_profit ASC
LIMIT 10;

-- 9. Effect of Discount on Profit (bucketed)
SELECT
    CASE
        WHEN od.discount = 0 THEN 'No Discount'
        WHEN od.discount <= 0.2 THEN 'Low (0-20%)'
        WHEN od.discount <= 0.4 THEN 'Medium (20-40%)'
        ELSE 'High (40%+)'
    END AS discount_band,
    COUNT(*) AS line_items,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit
FROM order_details od
GROUP BY discount_band
ORDER BY total_sales DESC;

-- 10. Customer Segment performance
SELECT
    c.segment,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit,
    COUNT(DISTINCT c.customer_id) AS customer_count
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;

-- 11. Return rate by Category
SELECT
    p.category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT r.order_id) AS returned_orders,
    ROUND(COUNT(DISTINCT r.order_id) / COUNT(DISTINCT o.order_id) * 100, 2) AS return_rate_pct
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN products p ON p.product_id = od.product_id
LEFT JOIN returns r ON r.order_id = o.order_id
GROUP BY p.category
ORDER BY return_rate_pct DESC;

-- 12. Top 5 States by Sales
SELECT
    c.state,
    ROUND(SUM(od.sales), 2)  AS total_sales,
    ROUND(SUM(od.profit), 2) AS total_profit
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_sales DESC
LIMIT 5;

-- 13. Customers with highest number of returned orders
SELECT
    c.customer_name,
    COUNT(r.order_id) AS returned_orders_count
FROM returns r
JOIN orders o ON o.order_id = r.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY returned_orders_count DESC
LIMIT 10;

-- 14. Average Order Value (AOV) by Segment
SELECT
    c.segment,
    ROUND(SUM(od.sales) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY avg_order_value DESC;

-- 15. Year-over-Year Sales Growth
SELECT
    YEAR(o.order_date) AS order_year,
    ROUND(SUM(od.sales), 2) AS total_sales,
    ROUND(
      (SUM(od.sales) - LAG(SUM(od.sales)) OVER (ORDER BY YEAR(o.order_date)))
      / LAG(SUM(od.sales)) OVER (ORDER BY YEAR(o.order_date)) * 100
    , 2) AS yoy_growth_pct
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
GROUP BY order_year
ORDER BY order_year;
