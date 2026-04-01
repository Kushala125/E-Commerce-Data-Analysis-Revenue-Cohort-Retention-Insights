USE commerce;
-- checking data
SELECT * FROM com ;
-- count total rows
SELECT COUNT(*) as total_rows
FROM com;
-- “Total number of unique customers in the dataset”'
SELECT COUNT(DISTINCT customer_id) AS  total_users
FROM com;
-- total revenue 
SELECT SUM(payment_value) AS total_revenue 
FROM com;
-- How much each order is worth?
SELECT
    SUM(payment_value) / COUNT(DISTINCT order_id) AS avg_order_value
FROM com;
-- “Customers spend around 170 per order on average.”
-- DAU (Daily Active Users)
-- “How many users are active each day?
SELECT 
order_date,
COUNT(DISTINCT customer_id) AS dau 
FROM com 
GROUP BY order_date 
ORDER BY order_date;
-- “There is a significant spike in DAU on 24th November 2017, likely due to a promotional event such as Black Friday.”
-- Product growth over time
SELECT 
    order_month,
    COUNT(DISTINCT customer_id) AS mau
FROM com
GROUP BY order_month
ORDER BY order_month;
-- “MAU shows steady growth with a peak during late 2017, likely driven by seasonal promotions and increased user adoption.”
-- DAU / MAU Ratio for User engagement
SELECT 
    d.order_date,
    d.dau,
    m.mau,
    d.dau / m.mau AS engagement_ratio
FROM 
(
    SELECT 
        order_date, 
        COUNT(DISTINCT customer_id) AS dau
    FROM com
    GROUP BY order_date
) d
JOIN 
(
    SELECT 
        order_month, 
        COUNT(DISTINCT customer_id) AS mau
    FROM com
    GROUP BY order_month
) m
ON LEFT(d.order_date, 7) = m.order_month;
-- “The DAU/MAU ratio stabilizes between 5–10%, indicating moderate user engagement, with users returning occasionally but not daily.”
-- RETENTION ANALYSIS
-- First Purchase Per User
SELECT 
    customer_id,
    MIN(order_date) AS first_purchase_date
FROM com
GROUP BY customer_id;
-- “I identified each user’s first purchase date to establish the starting point for retention and cohort analysis.” 
-- “How many users came back again?” 
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM com
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
-- The dataset shows very low repeat user behavior, with only around 3–4% of users making more than one purchase.
-- Retention Rate
SELECT 
    COUNT(DISTINCT CASE WHEN orders > 1 THEN customer_id END) 
    / COUNT(DISTINCT customer_id) AS retention_rate
FROM (
    SELECT customer_id, COUNT(order_id) AS orders
    FROM com
    GROUP BY customer_id
) t;
-- “The retention rate is extremely low at around 3.4%, indicating that the majority of users do not return after their first purchase.”
-- “Despite strong user acquisition, retention is very low, which suggests a growth problem driven by poor repeat engagement.”
-- Users who never came back
SELECT COUNT(*) AS churn_users
FROM (
    SELECT customer_id
    FROM com
    GROUP BY customer_id
    HAVING COUNT(order_id) = 1
) t;
-- “The churn rate is extremely high at around 96%, indicating that the vast majority of users do not return after their first interaction.”
-- FUNNEL ANALYSIS 
-- Where are users dropping off?
SELECT 
    COUNT(DISTINCT customer_id) AS users,
    COUNT(DISTINCT order_id) AS orders,
    SUM(payment_value) AS revenue
FROM com;
-- “There is no drop-off between users and orders, indicating that nearly every user completes a purchase, but fails to return.”
--  Conversion Rates
SELECT 
    COUNT(DISTINCT customer_id) AS users,
    COUNT(DISTINCT order_id) AS orders,
    SUM(payment_value) AS revenue,
    
    COUNT(DISTINCT order_id) * 1.0 / COUNT(DISTINCT customer_id) AS user_to_order_conversion,
    
    SUM(payment_value) / COUNT(DISTINCT order_id) AS avg_revenue_per_order

FROM com;
-- “The business generates consistent revenue per order, but growth is limited due to poor repeat purchase behavior.”
-- Which products drive revenue? 
SELECT 
    product_category_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(payment_value) AS revenue,
    AVG(payment_value) AS avg_order_value
FROM com
GROUP BY product_category_name
ORDER BY revenue DESC;
-- computers → AOV ~1296 🔥
-- home_appliances_2 → ~514
-- fixed_telephony → ~418
-- The business relies on a combination of high-volume categories for consistent revenue and high-value categories for profitability, while facing challenges in retention and category data quality.”
-- TOP 5 CATEGORIES
SELECT 
    product_category_name,
    SUM(payment_value) AS revenue
FROM com
GROUP BY product_category_name
ORDER BY revenue DESC
LIMIT 5;
-- ADD SHARE
WITH category_revenue AS (
    SELECT 
        product_category_name,
        SUM(payment_value) AS revenue
    FROM com
    GROUP BY product_category_name
),

final AS (
    SELECT 
        product_category_name,
        revenue,
        RANK() OVER (ORDER BY revenue DESC) AS category_rank,
        revenue / SUM(revenue) OVER () AS revenue_share
    FROM category_revenue
)

SELECT *
FROM final
WHERE category_rank <= 5;
-- “The top 5 product categories contribute around 40% of total revenue, indicating a strong concentration in a few key segments.”
-- Repeat Purchase Funnel
SELECT 
    COUNT(DISTINCT customer_id) AS total_users,

    COUNT(DISTINCT CASE WHEN order_count >= 1 THEN customer_id END) AS first_purchase,

    COUNT(DISTINCT CASE WHEN order_count >= 2 THEN customer_id END) AS repeat_users,

    COUNT(DISTINCT CASE WHEN order_count >= 3 THEN customer_id END) AS loyal_users

FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM com
    GROUP BY customer_id
) t;
WITH user_orders AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM com
    GROUP BY customer_id
)

SELECT 
    COUNT(*) AS total_users,

    COUNT(CASE WHEN order_count >= 2 THEN 1 END) AS repeat_users,
    COUNT(CASE WHEN order_count >= 3 THEN 1 END) AS loyal_users,

    COUNT(CASE WHEN order_count >= 2 THEN 1 END) * 1.0 / COUNT(*) AS repeat_rate,
    COUNT(CASE WHEN order_count >= 3 THEN 1 END) * 1.0 / COUNT(*) AS loyalty_rate

FROM user_orders;
-- “The repeat rate is only 3.4%, and the loyalty rate is below 1%, indicating a severe retention problem where users are not forming long-term engagement with the product.”
-- FIND WHERE USERS DROP user segmentation and funnel analysis 
WITH user_orders AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM com
    GROUP BY customer_id
)

SELECT 
    COUNT(*) AS total_users,

    SUM(order_count >= 1) AS step_1_users,
    SUM(order_count >= 2) AS step_2_users,
    SUM(order_count >= 3) AS step_3_users,

    SUM(order_count >= 2) * 1.0 / SUM(order_count >= 1) AS step1_to_step2,

    SUM(order_count >= 3) * 1.0 / SUM(order_count >= 2) AS step2_to_step3

FROM user_orders;
WITH user_orders AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count,
        SUM(payment_value) AS total_spent
    FROM com
    GROUP BY customer_id
),

segmented AS (
    SELECT *,
        CASE 
            WHEN order_count = 1 THEN 'One-time'
            WHEN order_count = 2 THEN 'Repeat'
            WHEN order_count >= 3 THEN 'Loyal'
        END AS user_type
    FROM user_orders
)

SELECT 
    user_type,
    COUNT(*) AS users,
    AVG(total_spent) AS avg_spent,
    SUM(total_spent) AS total_revenue,
    SUM(total_spent) * 1.0 / SUM(SUM(total_spent)) OVER () AS revenue_share
FROM segmented
GROUP BY user_type;
-- “The business relies heavily on one-time users (92% of revenue), while repeat and loyal users are very limited. However, repeat and loyal users have significantly higher average spend, indicating strong potential for revenue growth through retention strategies
-- cohort analysis 
-- REVENUE COHORT
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(STR_TO_DATE(order_date, '%Y-%m-%d')) AS first_order_date
    FROM com
    GROUP BY customer_id
),

cohort_data AS (
    SELECT 
        c.customer_id,
        DATE_FORMAT(f.first_order_date, '%Y-%m') AS cohort_month,
        c.payment_value
    FROM com c
    JOIN first_purchase f 
        ON c.customer_id = f.customer_id
),

cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_users
    FROM cohort_data
    GROUP BY cohort_month
)

SELECT 
    c.cohort_month,

    COUNT(DISTINCT c.customer_id) AS users,

    SUM(c.payment_value) AS total_revenue,

    ROUND(
        SUM(c.payment_value) * 1.0 / COUNT(DISTINCT c.customer_id),
        2
    ) AS revenue_per_user   -- LTV

FROM cohort_data c
GROUP BY c.cohort_month
ORDER BY c.cohort_month;
-- “Users generate most of their value in the first purchase.
-- Since retention is very low, growth should focus on increasing repeat purchases rather than acquisition.”
-- North star metric 
-- Users don’t come back after first purchase?
WITH user_orders AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM com
    GROUP BY customer_id
)

SELECT 
    COUNT(*) AS total_users,
    SUM(order_count >= 2) AS repeat_users,
    
    ROUND(
        SUM(order_count >= 2) * 1.0 / COUNT(*),
        4
    ) AS repeat_purchase_rate

FROM user_orders;
-- “I chose repeat purchase rate as the North Star Metric because it directly reflects user retention and long-term value. My analysis showed that only ~3.4% of users make a second purchase, indicating a major drop-off after the first transaction. Improving this metric would significantly increase lifetime value and overall revenue.”
-- “Is the business overly dependent on a small group of customers?”
WITH user_revenue AS (
    SELECT 
        customer_id,
        SUM(payment_value) AS total_spent
    FROM com
    GROUP BY customer_id
),

ranked AS (
    SELECT 
        customer_id,
        total_spent,
        NTILE(10) OVER (ORDER BY total_spent DESC) AS decile
    FROM user_revenue
),

final AS (
    SELECT 
        decile,
        COUNT(*) AS users,
        SUM(total_spent) AS revenue,
        SUM(total_spent) * 1.0 / SUM(SUM(total_spent)) OVER () AS revenue_share
    FROM ranked
    GROUP BY decile
)

SELECT *
FROM final
ORDER BY decile;
-- “I analyzed revenue concentration using decile segmentation and found that a small percentage of users contributes a disproportionately large share of revenue. This indicates dependency risk. I would recommend focusing on retaining high-value users while also improving conversion of mid-tier users to reduce reliance on a small segment
-- . Retention Curve
-- How many users return over time after their first purchase?
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_date
    FROM com
    GROUP BY customer_id
),

retention_data AS (
    SELECT 
        c.customer_id,
        f.first_date,
        c.order_date,
        TIMESTAMPDIFF(MONTH, f.first_date, c.order_date) AS cohort_index
    FROM com c
    JOIN first_purchase f 
        ON c.customer_id = f.customer_id
)

SELECT 
    cohort_index,
    COUNT(DISTINCT customer_id) AS users
FROM retention_data
GROUP BY cohort_index
ORDER BY cohort_index;
-- How does retention vary across different user cohorts over time
-- Do newer users behave better or worse?
-- How retention changes month by month
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_date
    FROM com
    GROUP BY customer_id
),

cohort_data AS (
    SELECT 
        c.customer_id,
        DATE_FORMAT(f.first_date, '%Y-%m') AS cohort_month,
        TIMESTAMPDIFF(MONTH, f.first_date, c.order_date) AS cohort_index
    FROM com c
    JOIN first_purchase f 
        ON c.customer_id = f.customer_id
)

SELECT 
    cohort_month,
    cohort_index,
    COUNT(DISTINCT customer_id) AS users
FROM cohort_data
GROUP BY cohort_month, cohort_index
ORDER BY cohort_month, cohort_index;
-- Even newer cohorts do not show improved retention, which suggests the issue is not due to specific campaigns or time periods, but rather a fundamental problem in user experience or engagement strategy.”