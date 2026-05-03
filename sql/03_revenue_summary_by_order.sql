-- ============================================
-- Fuzzy Factory | Maven Analytics
-- Table: revenue_summary_by_order
-- Description: Daily distinct order count
-- and revenue used for orders KPI in the
-- Sales Summary dashboard
-- ============================================
SELECT
  DATE(created_at) AS date,
  COUNT(DISTINCT order_id) AS orders,
  SUM(price_usd) AS revenue
FROM `e-commerce-project-489316.fuzzy_factory.orders`
GROUP BY 1
ORDER BY 1;
