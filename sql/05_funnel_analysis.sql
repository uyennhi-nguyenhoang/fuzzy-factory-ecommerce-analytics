-- ============================================
-- Fuzzy Factory | Maven Analytics
-- Table: funnel_analysis
-- Description: Session-level funnel flags
-- per step aggregated by source, campaign,
-- device, and date for funnel dashboard
-- ============================================
WITH funnel_sessions AS
(
  SELECT
    ws.website_session_id,
    ws.utm_source,
    ws.utm_campaign,
    ws.device_type,
    DATE(ws.created_at) AS date,


    -- Landing page (any entry point)
    MAX(CASE WHEN wp.pageview_url IN
      ('/home','/lander-1','/lander-2',
       '/lander-3','/lander-4','/lander-5')
    THEN 1 ELSE 0 END) AS saw_landing,
   
    -- Products page
    MAX(CASE WHEN wp.pageview_url = '/products'
    THEN 1 ELSE 0 END) AS saw_products,
   
    -- Any product detail page
    MAX(CASE WHEN wp.pageview_url IN
      ('/the-original-mr-fuzzy',
       '/the-forever-love-bear',
       '/the-birthday-sugar-panda',
       '/the-hudson-river-mini-bear')
    THEN 1 ELSE 0 END) AS saw_product_detail,
   
    -- Cart
    MAX(CASE WHEN wp.pageview_url = '/cart'
    THEN 1 ELSE 0 END) AS saw_cart,
   
    -- Shipping
    MAX(CASE WHEN wp.pageview_url = '/shipping'
    THEN 1 ELSE 0 END) AS saw_shipping,
   
    -- Billing (both versions)
    MAX(CASE WHEN wp.pageview_url IN
      ('/billing','/billing-2')
    THEN 1 ELSE 0 END) AS saw_billing,
   
    -- Thank you = converted
    MAX(CASE WHEN wp.pageview_url =
      '/thank-you-for-your-order'
    THEN 1 ELSE 0 END) AS converted


  FROM website_sessions ws
  LEFT JOIN website_pageviews wp
    ON ws.website_session_id = wp.website_session_id
  GROUP BY 1, 2, 3, 4, 5
)
SELECT
  utm_source,
  utm_campaign,
  device_type,
  date,
  SUM(saw_landing)        AS sessions,
  SUM(saw_products)       AS saw_products,
  SUM(saw_product_detail) AS saw_product_detail,
  SUM(saw_cart)           AS saw_cart,
  SUM(saw_shipping)       AS saw_shipping,
  SUM(saw_billing)        AS saw_billing,
  SUM(converted)          AS orders
FROM funnel_sessions
GROUP BY 1, 2, 3, 4
