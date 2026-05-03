-- ============================================
-- Fuzzy Factory | Maven Analytics
-- Table: customer_type_by_month
-- Description: Monthly order counts split
-- by new vs returning customers based on
-- lifetime order history using ROW_NUMBER()
-- ============================================
WITH customer_orders AS 
  (
    SELECT
        user_id,
        order_id,
        created_at,
        DATE_TRUNC(created_at, MONTH) AS order_month,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY created_at
        ) AS order_number
    FROM orders
),


classified_orders AS 
  (
    SELECT
        *,
        CASE
            WHEN order_number = 1 THEN 'New'
            ELSE 'Returning'
        END AS customer_type
    FROM customer_orders
)


SELECT
    order_month,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN customer_type = 'New'
        THEN 1 ELSE 0 END) AS new_orders,
    SUM(CASE WHEN customer_type = 'Returning'
        THEN 1 ELSE 0 END) AS returning_orders,
    ROUND(SUM(CASE WHEN customer_type = 'Returning'
        THEN 1 ELSE 0 END) / COUNT(*), 4) AS returning_rate_pct
FROM classified_orders
GROUP BY order_month
ORDER BY order_month;
