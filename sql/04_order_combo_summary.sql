-- ============================================
-- Fuzzy Factory | Maven Analytics
-- Table: order_combo_summary
-- Description: Product pairing frequency
-- from self-join on order_items to identify
-- cross-sell patterns and combo orders
-- ============================================
WITH combos AS (
  SELECT
    CASE WHEN a.product_id = 1 THEN 'The Original Mr. Fuzzy'
         WHEN a.product_id = 2 THEN 'The Forever Love Bear'
         WHEN a.product_id = 3 THEN 'The Birthday Sugar Panda'
         WHEN a.product_id = 4 THEN 'The Hudson River Mini Bear'
    END AS product_1,
    CASE WHEN b.product_id = 1 THEN 'The Original Mr. Fuzzy'
         WHEN b.product_id = 2 THEN 'The Forever Love Bear'
         WHEN b.product_id = 3 THEN 'The Birthday Sugar Panda'
         WHEN b.product_id = 4 THEN 'The Hudson River Mini Bear'
    END AS product_2,
    COUNT(DISTINCT a.order_id) AS combo_orders
  
  FROM order_items a
  JOIN order_items b
    ON a.order_id = b.order_id
    AND a.product_id < b.product_id  -- avoids duplicates and self-joins
  
  GROUP BY 1, 2
  ORDER BY combo_orders DESC
  ),


solo AS (
  SELECT
      CASE WHEN product_id = 1 THEN 'The Original Mr. Fuzzy'
           WHEN product_id = 2 THEN 'The Forever Love Bear'
           WHEN product_id = 3 THEN 'The Birthday Sugar Panda'
           WHEN product_id = 4 THEN 'The Hudson River Mini Bear'
      END AS product_1,
      'Ordered Alone' AS product_2,
      COUNT(DISTINCT order_id) AS combo_orders
  FROM order_items
  WHERE order_id NOT IN (
      -- orders that have more than 1 product
      SELECT order_id
      FROM order_items
      GROUP BY order_id
      HAVING COUNT(product_id) > 1
    )
  GROUP BY 1
  ORDER BY combo_orders DESC
)
  
SELECT * FROM combos
UNION ALL
SELECT * FROM solo
ORDER BY combo_orders DESC;
