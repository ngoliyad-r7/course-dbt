What is our overall conversion rate? -- 62.4%

What is our conversion rate by product?

WITH
    CTE_PURCHASE_SESS AS (
        SELECT 
            session_id,
            event_type,
            order_id
        FROM STG_EVENTS
        WHERE event_type = 'checkout'),
        
    CTE_TOTAL_SESS AS (
        SELECT DISTINCT session_id FROM STG_EVENTS),
        
    CTE_SESS_CONV AS (
        SELECT 
            (SELECT COUNT(DISTINCT session_id) FROM CTE_PURCHASE_SESS)
            /
            COUNT(DISTINCT session_id) as CONVERSION_RATE
        FROM CTE_TOTAL_SESS),
        
//SELECT * FROM CTE_SESS_CONV;

    CTE_PURCHASE_SESS_ORDERS AS (
        SELECT 
            ps.*,
            oi.product_id,
            p.name
        FROM CTE_PURCHASE_SESS ps
        LEFT JOIN ORDER_ITEMS oi ON oi.order_id = ps.order_id
        LEFT JOIN PRODUCTS p on p.product_id = oi.product_id),
        
    CTE_PROD_VIEWS AS (
        SELECT
            e.session_id,
            e.event_type,
            e.order_id,
            e.product_id,
            p.name
        FROM STG_EVENTS e
        LEFT JOIN PRODUCTS p ON p.product_id = e.product_id
        WHERE event_type = 'page_view'),
        
    CTE_PROD_CONV AS (
        SELECT
            name,
            (SELECT COUNT(DISTINCT session_id) FROM CTE_PURCHASE_SESS_ORDERS)
            /
            COUNT(DISTINCT session_id) as PROD_CONVERSION_RATE
        FROM CTE_PROD_VIEWS
        GROUP BY 1)
            
SELECT * FROM CTE_PROD_CONV;