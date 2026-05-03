-- ============================================
-- Fuzzy Factory | Maven Analytics
-- Table: order_and_refund_by_product
-- Description: Daily product-level revenue,
-- COGS, items sold, and refunded items for
-- product performance and margin analysis
-- ============================================
SELECT
  DATE(oi.created_at) AS date,
  oi.product_id,
  CASE
    WHEN oi.product_id = 1 THEN 'The Original Mr. Fuzzy'
    WHEN oi.product_id = 2 THEN 'The Forever Love Bear'
    WHEN oi.product_id = 3 THEN 'The Birthday Sugar Panda'
    WHEN oi.product_id = 4 THEN 'The Hudson River Mini Bear'
    END AS product_name,
  COUNT(oi.order_id) AS orders,
  SUM(oi.price_usd) AS revenue,
  SUM(oi.cogs_usd) AS cogs,
  SUM(CASE WHEN r.order_item_id IS NOT NULL THEN 1 ELSE 0 END) AS refunded_items
FROM order_items AS oi
LEFT JOIN order_item_refunds AS r
  ON oi.order_item_id = r.order_item_id
GROUP BY 1,2
ORDER BY 1,2;
