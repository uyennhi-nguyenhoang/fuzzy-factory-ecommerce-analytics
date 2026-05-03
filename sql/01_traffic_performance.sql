-- ============================================
-- Fuzzy Factory | Maven Analytics
-- Table: traffic_performance
-- Description: Sessions, orders, and revenue
-- aggregated by source, campaign, device,
-- and date for digital performance analysis
-- ============================================
SELECT
  DATE(ws.created_at) AS date,
  ws.utm_source,
  ws.utm_campaign,
  ws.device_type,
  COUNT(DISTINCT ws.website_session_id) AS sessions,
  COUNT(DISTINCT o.order_id) AS orders,
  SUM(o.price_usd) AS revenue
FROM website_sessions AS ws
LEFT JOIN orders AS o
  ON ws.website_session_id = o.website_session_id
GROUP BY 1,2,3,4
ORDER BY 1;

