<div align="center">

<!-- ANIMATED WAVE HEADER -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:06080f,50:0d1f3c,100:00e5ff&height=280&section=header&text=E-Commerce%20Data%20Analysis&fontSize=38&fontColor=ffffff&fontAlignY=40&desc=Revenue%20·%20Cohort%20·%20Retention%20Insights&descAlignY=62&descSize=16&animation=fadeIn" width="100%"/>

<!-- TYPING ANIMATION -->
<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=700&size=22&pause=1200&color=00E5FF&center=true&vCenter=true&width=700&height=60&lines=The+Customer+Retention+Crisis+🔴;96%25+Churn+Rate+Uncovered+📊;SQL+%2B+Python+%2B+Tableau+End-to-End+🛠️;From+Data+to+Business+Strategy+💡;Repeat+Purchase+Rate+%3A+Only+~3%25+🪣" alt="Typing SVG" />

<br/>

<!-- ANIMATED STATS BADGES -->
<img src="https://img.shields.io/badge/Retention%20Rate-3.4%25-ff3d5a?style=for-the-badge&labelColor=06080f&logo=databricks&logoColor=ff3d5a" />
<img src="https://img.shields.io/badge/Avg%20Order%20Value-₹170-ffc947?style=for-the-badge&labelColor=06080f&logo=stripe&logoColor=ffc947" />
<img src="https://img.shields.io/badge/HV%20Conversion-86%25-00e676?style=for-the-badge&labelColor=06080f&logo=checkmarx&logoColor=00e676" />
<img src="https://img.shields.io/badge/Churn%20Rate-~96%25-ff6b35?style=for-the-badge&labelColor=06080f&logo=firefoxbrowser&logoColor=ff6b35" />

<br/><br/>

<!-- TOOL BADGES -->
<img src="https://img.shields.io/badge/MySQL-SQL%20Analytics-00e5ff?style=flat-square&logo=mysql&logoColor=white&labelColor=0d1f3c"/>
<img src="https://img.shields.io/badge/Python-Pandas%20%7C%20Matplotlib%20%7C%20Plotly-00e5ff?style=flat-square&logo=python&logoColor=white&labelColor=0d1f3c"/>
<img src="https://img.shields.io/badge/Tableau-Business%20Intelligence-00e5ff?style=flat-square&logo=tableau&logoColor=white&labelColor=0d1f3c"/>
<img src="https://img.shields.io/badge/Jupyter-Notebook-00e5ff?style=flat-square&logo=jupyter&logoColor=white&labelColor=0d1f3c"/>

</div>

---

## 🪣 The Business Story — Growth vs. Sustainability

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:1a0a00,100:3d1500&height=3&section=header" width="100%"/>

> **The data initially shows a business in a high-growth phase.** Revenue and order volumes hit record highs month-over-month.  
> **The deeper truth?** This growth was built on sand.

The business ran on a **"one-and-done" model**. The marketing engine was efficient at bringing users to the storefront. The post-purchase experience failed, completely, to turn them into loyalists.

```
📥 Acquire → 🛒 First Purchase → 👋 Never Seen Again (96% of the time)
```

This creates a **dangerous dependency** on constant, expensive ad spend just to maintain flat revenue — a treadmill with no off switch.

---

## 📊 The Customer Journey Funnel

<div align="center">

```
┌─────────────────────────────────────────────────┐
│           ALL USERS              100%   🌐       │
├──────────────────────────────────────────────────┤
│         ENGAGED USERS             29%   📱       │
├────────────────────────────────────────────┤
│       FIRST PURCHASE             ~100%  🛒       │
├──────────────────────────┤
│     REPEAT BUYERS          ~3%   🔁              │
├─────────┤
│  LOYAL    <1%  💎                                │
└─────────┘
```

| Stage | Rate | Signal |
|-------|------|--------|
| All Users → Engaged | **29%** | 🟡 Onboarding problem |
| Engaged → First Purchase | **~100%** | 🟢 Product works |
| First → Repeat Purchase | **~3%** | 🔴 **CRITICAL failure** |
| Repeat → Loyal | **< 1%** | 🔴 No loyalty loop |

</div>

> 💡 **The product clearly works.** Once users engage, 86% convert to high-value. The problem is everything that happens *after* the package arrives.

---

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0d1f3c,100:001a2e&height=2" width="100%"/>

## 🗄️ Part 1 — SQL Analytics

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=600&size=16&pause=900&color=FF6B35&center=true&vCenter=true&width=600&height=40&lines=MySQL+%7C+17+Queries+%7C+From+KPIs+to+Cohorts" alt="SQL typing" />
</div>

---

### 📈 Q1 · Daily Orders Trend

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart1.png" width="80%" alt="Daily Orders Chart"/>
</div>

**❓ Question:** How does order volume change over time — are there any spikes?

**💡 Insight:**  
The daily order trend shows a clear upward trajectory, confirming business growth. A major spike indicates a successful promotional event. Post-event activity remains elevated, suggesting partial customer retention after campaigns.

```sql
SELECT
    order_date,
    COUNT(DISTINCT customer_id) AS daily_active_users
FROM com
GROUP BY order_date
ORDER BY order_date;
```

> 🔥 **Key Finding:** Spike on **Nov 24, 2017 (Black Friday)** — single largest order volume day in the dataset.

---

### 💰 Q2 · Daily Revenue Trend

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart2.png" width="80%" alt="Daily Revenue Chart"/>
</div>

**❓ Question:** Is revenue growing consistently? What causes the fluctuations?

**💡 Insight:**  
Revenue mirrors order growth but with amplified spikes — meaning high-value transactions are pulling averages up. Revenue is driven by **both volume AND purchase size**, not one factor alone. Large spikes point to specific high-value transaction days.

```sql
SELECT
    SUM(payment_value) AS total_revenue,
    SUM(payment_value) / COUNT(DISTINCT order_id) AS avg_order_value
FROM com;
```

> 📊 **AOV ≈ ₹170 per order** — strong baseline purchasing power across the customer base.

---

### 📆 Q3 · Monthly Orders vs Revenue

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart3.png" width="80%" alt="Monthly Orders vs Revenue"/>
</div>

**❓ Question:** Is growth driven by order volume or higher spending per order?

**💡 Insight:**  
Peak performance in early 2018. Revenue growth is **not proportional** to order volume — customers were spending more per transaction rather than ordering more frequently. Revenue concentration in specific months confirms dangerous dependence on seasonal or promotional windows.

```sql
SELECT
    order_month,
    COUNT(DISTINCT order_id) AS monthly_orders,
    SUM(payment_value) AS revenue,
    AVG(payment_value) AS avg_order_value
FROM com
GROUP BY order_month
ORDER BY order_month;
```

> ⚠️ **Risk:** Seasonal revenue concentration means a bad Q4 campaign could crater annual numbers.

---

### 📉 Q4 · Revenue Distribution & Engagement Ratio

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart4.png" width="80%" alt="Revenue Distribution"/>
</div>

**❓ Question:** Is revenue concentrated among a small group? How engaged are daily users?

**💡 Insight:**  
The DAU/MAU engagement ratio sits at **5–10%**. Users are not habitually active — the platform is a *destination*, not a *daily habit*. This explains why campaigns spike activity but organic daily usage remains thin.

```sql
SELECT
    d.order_date,
    d.daily_active_users * 1.0 / m.monthly_active_users AS engagement_ratio
FROM (
    SELECT order_date, COUNT(DISTINCT customer_id) AS daily_active_users
    FROM com GROUP BY order_date
) d
JOIN (
    SELECT order_month, COUNT(DISTINCT customer_id) AS monthly_active_users
    FROM com GROUP BY order_month
) m ON LEFT(d.order_date, 7) = m.order_month;
```

> 📌 **DAU/MAU: 5–10%** — weak daily engagement; platform needs habit-forming features.

---

### 🔁 Q5 · Repeat Users & Retention Rate

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart5.png" width="80%" alt="Customer Segmentation CLV"/>
</div>

**❓ Question:** What percentage of users actually come back?

**💡 Insight:**  
Only **3–4% of users** return after their first purchase. The funnel collapses almost immediately post-acquisition. This is the single most important metric to fix — and it has nothing to do with marketing.

```sql
-- Retention Rate
SELECT
    COUNT(DISTINCT CASE WHEN orders > 1 THEN customer_id END) * 1.0
    / COUNT(DISTINCT customer_id) AS retention_rate
FROM (
    SELECT customer_id, COUNT(order_id) AS orders
    FROM com GROUP BY customer_id
) t;

-- Repeat Users Only
SELECT customer_id, COUNT(order_id) AS total_orders
FROM com
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
```

> 🚨 **Retention Rate ≈ 3.4%** — the single most critical number in this entire analysis.

---

### 🛒 Q6 · Revenue by Product Category

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart6.png" width="80%" alt="Conversion Funnel"/>
</div>

**❓ Question:** Which categories drive revenue — and which expose us to concentration risk?

**💡 Insight:**  
Top 5 categories contribute **~40% of total revenue**. High-AOV categories dominate through transaction size; others compensate through order frequency. This concentration is both a strength (clear focus areas) and a vulnerability (single category softness = outsized revenue impact).

```sql
SELECT
    product_category_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(payment_value) AS revenue,
    AVG(payment_value) AS avg_order_value
FROM com
GROUP BY product_category_name
ORDER BY revenue DESC
LIMIT 5;
```

> 🏆 Top 5 categories → **~40% of revenue.** Heavy concentration. A must-diversify signal.

---

### 🔁 Q7 · Cohort Retention Analysis

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart7.png" width="80%" alt="Cohort Retention"/>
</div>

**❓ Question:** Do customers return after their first purchase, month over month?

**💡 Insight:**  
Cohort retention shows **100% activity only in month 0** (acquisition month). Every subsequent month: near-zero return. Users appear once, buy once, disappear. The platform operates as a transactional marketplace, not a loyalty ecosystem.

```sql
WITH first_purchase AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM com GROUP BY customer_id
)
SELECT
    DATE_FORMAT(first_order_date, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT customer_id) AS users
FROM first_purchase
GROUP BY cohort_month
ORDER BY cohort_month;
```

> 🔴 **Month 1+ retention ≈ 0% across ALL cohorts.** There is no loyalty loop.

---

### 💸 Q8 · Revenue Cohort Retention

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart8.png" width="80%" alt="Revenue Cohort"/>
</div>

**❓ Question:** How does revenue retention vary across acquisition cohorts?

**💡 Insight:**  
Revenue cohort analysis confirms: revenue exists only in month 0 across every cohort. No cohort generates meaningful recurrence. This redirects strategy: **the business should prioritize acquisition quality and first-time conversion optimization** before investing in retention programs on a non-existent repeat base.

```sql
WITH first_purchase AS (
    SELECT customer_id, MIN(order_date) AS first_date
    FROM com GROUP BY customer_id
)
SELECT
    TIMESTAMPDIFF(MONTH, f.first_date, c.order_date) AS months_after,
    COUNT(DISTINCT c.customer_id) AS returning_users
FROM com c
JOIN first_purchase f ON c.customer_id = f.customer_id
GROUP BY months_after
ORDER BY months_after;
```

> 🎯 **Focus point:** Fix the post-purchase experience first. Then build retention infrastructure.

---

### 👤 Q9 · User Segmentation

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart13.png" width="80%" alt="3D Segmentation"/>
</div>

**❓ Question:** How are customers distributed across value segments?

**💡 Insight:**  
One-time users dominate both count and revenue. But repeat and loyal users spend **significantly more per person**. If just 10% of one-time buyers became repeat buyers, revenue could jump substantially without a single new ad spend dollar.

```sql
WITH user_orders AS (
    SELECT customer_id,
           COUNT(order_id) AS order_count,
           SUM(payment_value) AS total_spent
    FROM com GROUP BY customer_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN '🔵 One-time'
        WHEN order_count = 2 THEN '🟡 Repeat'
        ELSE '🟢 Loyal'
    END AS user_type,
    COUNT(*) AS users,
    AVG(total_spent) AS avg_spent,
    SUM(total_spent) AS total_revenue
FROM user_orders
GROUP BY user_type;
```

| Segment | % of Users | Avg Spend | Revenue Share |
|---------|-----------|-----------|---------------|
| 🔵 One-time | ~93% | Lower | Dominant by volume |
| 🟡 Repeat | ~4% | Higher | Disproportionate |
| 🟢 Loyal | < 1% | Highest | Extreme CLV |

---

### 💎 Q10 · Revenue Concentration (NTILE)

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart15.png" width="80%" alt="Revenue Concentration"/>
</div>

**❓ Question:** How concentrated is revenue across the user base?

**💡 Insight:**  
NTILE(10) decile analysis confirms the **Pareto pattern** — a small group of users drives a disproportionate share of total revenue. This creates concentration risk: if the top decile churns, revenue damage would be immediate and severe.

```sql
WITH user_revenue AS (
    SELECT customer_id, SUM(payment_value) AS total_spent
    FROM com GROUP BY customer_id
)
SELECT
    NTILE(10) OVER (ORDER BY total_spent DESC) AS decile,
    COUNT(*) AS users,
    SUM(total_spent) AS revenue
FROM user_revenue
GROUP BY decile
ORDER BY decile;
```

> ⚠️ **Pareto confirmed:** Top segment holds outsized revenue share. These users must be protected.

---

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0d1f3c,100:001a2e&height=2" width="100%"/>

## 🐍 Part 2 — Python Analytics

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=600&size=16&pause=900&color=00E676&center=true&vCenter=true&width=650&height=40&lines=Pandas+%7C+Matplotlib+%7C+Plotly+3D+%7C+North+Star+Metric" alt="Python typing" />
</div>

---

### ⭐ Q11 · Revenue per User — The North Star Metric

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart11.png" width="80%" alt="Revenue per User"/>
</div>

**❓ Question:** Is revenue generated per user improving over time?

**💡 Insight:**  
Revenue per User (RPU) was chosen as the North Star Metric because it balances both user growth and monetization simultaneously. A dip during mid-scaling reveals **lower-quality user acquisition** — chasing volume at the cost of value. The strong recovery in 2018 signals the business matured from growth-at-all-costs to value-focused scaling.

```python
# Monthly revenue and unique users
monthly_rev   = df.groupby('order_month')['payment_value'].sum()
monthly_users = df.groupby('order_month')['customer_id'].nunique()

# North Star = Revenue per User
rpu = monthly_rev / monthly_users
rpu.plot(kind='line', title='Revenue per User (North Star Metric)',
         color='#00e5ff', figsize=(12, 5))
```

> 📈 **2018 RPU recovery** = the business stopped buying cheap users and started earning valuable ones.

---

### 📈 Q12 · Revenue Growth Rate

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart12.png" width="80%" alt="Revenue Growth Rate"/>
</div>

**❓ Question:** How fast is the business actually growing month-over-month?

**💡 Insight:**  
High volatility, especially early on (small base effect). Strong spikes occur during promotional months, but the **lack of consistency reveals campaign-driven rather than organic growth**. The business needs to analyse what made peak months work — and replicate those conditions as a baseline.

```python
# Group by month, calculate MoM % change
monthly_revenue = df.groupby('order_month')['payment_value'].sum()
growth_rate     = monthly_revenue.pct_change() * 100

print(growth_rate)
growth_rate.plot(kind='bar', title='Month-over-Month Revenue Growth %',
                 color='#ff6b35', figsize=(14, 5))
```

> 🔄 **High variance = campaign dependency.** Organic baseline growth needs to be built.

---

### 💎 Q13 · Customer Lifetime Value Distribution

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart9.png" width="80%" alt="CLV Distribution"/>
</div>

**❓ Question:** How is Customer Lifetime Value distributed across the base?

**💡 Insight:**  
CLV was segmented into quartiles. While quartile splits appear even by construction, **combining this with Pareto analysis reveals severe skew** — a small group of customers holds an outsized share of total lifetime revenue. The bottom quartile contributes near-negligibly; the top quartile is mission-critical to retain.

```python
# Identify the top 25% spending threshold
threshold     = df['payment_value'].quantile(0.75)
high_value    = df[df['payment_value'] > threshold]['customer_id'].nunique()
total_users   = df['customer_id'].nunique()

ratio = (high_value / total_users) * 100
print(f"High-Value Segment: {ratio:.2f}% of the user base")
```

> 💡 **Top 25% of spenders = majority of total revenue.** Every churn from this group hurts.

---

### 🔮 Q14 · 3D Customer Segmentation (Plotly)

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart10.png" width="80%" alt="3D Segmentation"/>
</div>

**❓ Question:** How do customers differ across multiple dimensions simultaneously?

**💡 Insight:**  
End-to-end analytics powered by Plotly — EDA, Pareto distribution, CLV modelling, and advanced 3D visualisation. Multi-dimensional segmentation reveals distinct customer clusters (frequency × recency × spend) that are invisible in standard 2D views. These clusters enable **precision targeting** rather than demographic guesswork.

> 🧠 **Three clusters emerge clearly:** infrequent high-spenders, frequent low-spenders, and the critical mid-tier with conversion potential.

---

### 🔻 Q15 · Customer Conversion Funnel

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/chart14.png" width="80%" alt="Conversion Funnel"/>
</div>

**❓ Question:** Where is the single biggest drop-off in the customer journey?

**💡 Insight:**  
The primary drop-off occurs at **the engagement stage** — only 29% of users become active participants. However, once a user engages, conversion to high-value is an extraordinary **86%**. The conclusion is unambiguous: **fix onboarding and early activation, not the product.**

```
Users (100%) → Engaged (29%) → High-Value (86% of engaged)
                 ↑
         THIS is where the battle is lost
```

> ✅ **The product converts brilliantly.** The experience that leads up to it does not.

---

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0d1f3c,100:001a2e&height=2" width="100%"/>

## 📊 Part 3 — Tableau Dashboard

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=600&size=16&pause=900&color=FFC947&center=true&vCenter=true&width=650&height=40&lines=Executive+Dashboard+%7C+Stakeholder+Storytelling" alt="Tableau typing" />
</div>

---

<div align="center">
<img src="https://raw.githubusercontent.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights/main/images/DASHBOARD.png" width="90%" alt="Tableau Dashboard"/>
</div>

**❓ Question:** How do we communicate these findings to executives and non-technical stakeholders?

**💡 Insight:**  
The Tableau workbook bridges the gap between raw query outputs and boardroom decisions. Three core narratives are visualised:

| Dashboard Focus | What It Shows | Business Question Answered |
|----------------|--------------|---------------------------|
| ⚡ **Black Friday Spike** | Nov 24, 2017 surge & drop-off | Is campaign growth sustainable? |
| 📈 **Revenue vs Orders** | Growth driver decomposition | Are we getting more — or better — customers? |
| 🎯 **Retention Funnel** | One-time vs repeat vs loyal | Where exactly is the value leaking? |

> 🏢 **Design principle:** Every dashboard answers one question a CFO or CMO would ask in a Monday morning review. No analyst jargon. Clear signal, clear action.

---

## 🔑 Key Business Findings

<div align="center">

| # | Finding | Data Point | Severity |
|---|---------|-----------|---------|
| 1 | Retention catastrophe | **~3.4%** repeat rate | 🔴 Critical |
| 2 | One-time buyer dominance | **6,444** vs **45** repeat users | 🔴 Critical |
| 3 | Category mismatch | Durables → low repurchase | 🟠 High |
| 4 | Engagement is the bottleneck | Only **29%** activate | 🟠 High |
| 5 | Revenue concentration (Pareto) | Top decile drives majority | 🟡 Medium |
| 6 | Campaign-driven volatility | No organic growth baseline | 🟡 Medium |
| 7 | Post-activation conversion | **86%** convert once engaged | 🟢 Strength |
| 8 | North Star recovery (2018) | RPU improved significantly | 🟢 Strength |

</div>

---

## 🚀 Strategic Recommendations

```
┌─────────────────────────────────────────────────────────────────────┐
│  01  IMPLEMENT A LOYALTY LOOP                                        │
│      Auto-trigger a second-purchase discount 7 days post-delivery.  │
│      Attack the highest-impact drop-off point directly.             │
├─────────────────────────────────────────────────────────────────────┤
│  02  CRM FOR HIGH-VALUE SEGMENTS                                     │
│      Replace broad-spectrum ads with VIP email sequences for the    │
│      top 25% of spenders. Stop paying to re-acquire loyalists.      │
├─────────────────────────────────────────────────────────────────────┤
│  03  POST-PURCHASE OPERATIONAL AUDIT                                 │
│      Retention failed even in high-revenue months → the problem     │
│      is after delivery. Audit shipping, packaging, support.         │
├─────────────────────────────────────────────────────────────────────┤
│  04  CROSS-SELL INTO CONSUMABLES                                     │
│      Durable goods buyers have low natural repurchase frequency.    │
│      Build recommendation logic for accessories & supplies.         │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Technical Stack

<div align="center">

<img src="https://skillicons.dev/icons?i=mysql,python,git,github&theme=dark" />

<br/><br/>

| Tool | Purpose | Output |
|------|---------|--------|
| **MySQL** | Data engineering, KPI queries, cohort CTEs | 17 analytical SQL queries |
| **Python · Pandas** | Time-series analysis, segmentation, North Star | Growth rate, RPU, quantile models |
| **Python · Matplotlib** | Static visualisations | 15 charts |
| **Python · Plotly** | Interactive 3D segmentation | CLV cluster map |
| **Tableau Desktop** | Executive dashboards | 3 stakeholder-ready views |

</div>

---

## 📁 Repository Structure

```
📦 E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights
 ┣ 📂 SQL/              # 17 analytical queries (AOV, DAU, cohorts, retention)
 ┣ 📂 notebook/         # Jupyter notebooks — Python EDA & advanced analytics
 ┣ 📂 data/             # Raw transactional dataset
 ┣ 📂 images/           # All 15+ chart outputs
 ┣ 📂 Dashboard/        # Tableau workbook files
 ┣ 📂 Tableau Dashboard/# Exported dashboard views
 ┗ 📄 README.md         # You are here
```

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:00e5ff,50:0d1f3c,100:06080f&height=180&section=footer&text=Built%20with%20SQL%20·%20Python%20·%20Tableau&fontSize=18&fontColor=ffffff&fontAlignY=55&animation=fadeIn" width="100%"/>

**By [Kushala](https://github.com/Kushala125)**  
*Moving from "How many new users did we get?" to "How many users did we keep?"*

[![GitHub](https://img.shields.io/badge/GitHub-Kushala125-00e5ff?style=for-the-badge&logo=github&logoColor=white&labelColor=06080f)](https://github.com/Kushala125/E-Commerce-Data-Analysis-Revenue-Cohort-Retention-Insights)

</div>
