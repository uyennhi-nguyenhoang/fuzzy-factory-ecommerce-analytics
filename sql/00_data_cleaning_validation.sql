-- ============================================
-- DATA CLEANING & VALIDATION
-- Fuzzy Factory | Maven Analytics Dataset
-- ============================================
-- Purpose: Validate all 5 raw tables before
-- analysis. Checks: NULLs, blanks, duplicates.
-- Result: All tables passed. 0 issues found.
-- ============================================


-- ============================================
-- 1. NULLs check
-- ============================================
--1.1 orders table
SELECT
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_null,
  SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) AS website_session_id_null,
  SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS user_id_null,
  SUM(CASE WHEN primary_product_id IS NULL THEN 1 ELSE 0 END) AS primary_product_id_null,
  SUM(CASE WHEN items_purchased IS NULL THEN 1 ELSE 0 END) AS items_purchased_null,
  SUM(CASE WHEN price_usd IS NULL THEN 1 ELSE 0 END) AS price_usd_null,
  SUM(CASE WHEN cogs_usd IS NULL THEN 1 ELSE 0 END) AS cogs_usd_null
FROM orders;


--1.2 order_items table
SELECT
  SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS order_item_id_null,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_null,
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_null,
  SUM(CASE WHEN is_primary_item IS NULL THEN 1 ELSE 0 END) AS is_primary_item_null,
  SUM(CASE WHEN price_usd IS NULL THEN 1 ELSE 0 END) AS price_usd_null,
  SUM(CASE WHEN cogs_usd IS NULL THEN 1 ELSE 0 END) AS cogs_usd_null
FROM order_items;


--1.3 order_item_refunds table
SELECT
  SUM(CASE WHEN order_item_refund_id IS NULL THEN 1 ELSE 0 END) AS order_item_refund_id_null,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_null,
  SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS order_item_id_null,
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
  SUM(CASE WHEN refund_amount_usd IS NULL THEN 1 ELSE 0 END) AS refund_amount_usd_null
FROM order_item_refunds;


--1.4 website_sessions table
SELECT
  SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) AS website_session_id_null,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_null,
  SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS user_id_null,
  SUM(CASE WHEN is_repeat_session IS NULL THEN 1 ELSE 0 END) AS is_repeat_session_null,
  SUM(CASE WHEN utm_source IS NULL THEN 1 ELSE 0 END) AS utm_source_null,
  SUM(CASE WHEN utm_campaign IS NULL THEN 1 ELSE 0 END) AS utm_campaign_null,
  SUM(CASE WHEN utm_content IS NULL THEN 1 ELSE 0 END) AS utm_content_null,
  SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS device_type_null,
  SUM(CASE WHEN http_referer IS NULL THEN 1 ELSE 0 END) AS http_referer_null
FROM website_sessions;


--1.5 website_pageviews table
SELECT
  SUM(CASE WHEN website_pageview_id IS NULL THEN 1 ELSE 0 END) AS website_pageview_id_null,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_null,
  SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) AS website_session_id_null,
  SUM(CASE WHEN pageview_url IS NULL THEN 1 ELSE 0 END) AS pageview_url_null
FROM website_pageviews;


-- ============================================
-- 2. Blank or empty strings check
-- ============================================

--2.1 orders table: no string type
--2.2 order_items table: no string type
--2.3 order_item_refunds table: no string type

--2.4 website_sessions table
SELECT *
FROM website_sessions
WHERE utm_source =''
  OR utm_campaign =''
  OR utm_content =''
  OR device_type =''
  OR http_referer ='';


--2.5 website_pageviews table
SELECT *
FROM website_pageviews
WHERE pageview_url =''

-- ============================================
-- 3. Duplicate detection
-- ============================================

--3.1 orders table
SELECT
  order_id, created_at, website_session_id,user_id, primary_product_id, items_purchased, price_usd, cogs_usd,
  COUNT(*) AS count
FROM orders
GROUP BY order_id, created_at, website_session_id,user_id, primary_product_id, items_purchased, price_usd, cogs_usd
HAVING COUNT(*) > 1;


--3.2 order_items table
SELECT
  order_item_id, created_at, order_id, product_id, is_primary_item, price_usd, cogs_usd,
  COUNT(*) AS count
FROM order_items
GROUP BY order_item_id, created_at, order_id, product_id, is_primary_item, price_usd, cogs_usd
HAVING COUNT(*) > 1;


--3.3 order_item_refunds table
SELECT
  order_item_refund_id, created_at, order_item_id, order_id, refund_amount_usd,
  COUNT(*) AS count
FROM order_item_refunds
GROUP BY order_item_refund_id, created_at, order_item_id, order_id, refund_amount_usd
HAVING COUNT(*) > 1;


--3.4 website_sessions table
SELECT
  website_session_id, created_at, user_id, is_repeat_session, utm_source, utm_campaign, utm_content, device_type, http_referer,
  COUNT(*) AS count
FROM website_sessions
GROUP BY website_session_id, created_at, user_id, is_repeat_session, utm_source, utm_campaign, utm_content, device_type, http_referer
HAVING COUNT(*) > 1;


--3.5 website_pageviews table
SELECT
  website_pageview_id, created_at, website_session_id, pageview_url,
  COUNT(*) AS count
FROM website_pageviews
GROUP BY website_pageview_id, created_at, website_session_id, pageview_url
HAVING COUNT(*) > 1;
