# Key Insights — Superstore Sales Analysis

Based on 3,000 sampled order-line records (2,270 orders) from the Superstore dataset.

---

### 1. Overall Performance
- Total Sales: **$719,731** | Total Profit: **$100,318** | Profit Margin: **13.94%**
- Insight: Margin is healthy overall, but it hides big swings between categories (see below).

---

### 2. Category Performance — Furniture is a margin problem, not a sales problem
| Category | Sales | Profit | Margin |
|---|---|---|---|
| Technology | $269,574 | $56,935 | ~21% |
| Office Supplies | $230,222 | $37,599 | ~16% |
| Furniture | $219,935 | $5,784 | **~2.6%** |

- **Insight:** Furniture generates almost as much revenue as Office Supplies but returns 6x less profit. This points to a pricing or cost problem specific to Furniture, not a demand problem.

---

### 3. Loss-Making Sub-Categories
- **Tables** lost **-$5,795** overall despite $68,048 in sales — the only sub-category with a negative total.
- Worst individual products were concentrated in **Tables, Binders, and Machines** (e.g. a single conference table lost -$1,688; a 3D printer lost -$2,640 on its own).
- **Insight:** Recommend a pricing/discount policy review specifically for Tables and high-value Machines — they're being discounted below profitable thresholds.

---

### 4. Discount Is Eating Profit
- Orders with **No Discount**: $370,508 in sales generated **$108,366** profit (~29% margin).
- Once discounting starts, margin drops sharply (see full breakdown in query #9 of `02_analysis_queries.sql`).
- **Insight:** Discounting above ~20% is where profitability turns negative in several categories — a cap or approval workflow on high discounts could protect margin.

---

### 5. Regional Performance
| Region | Sales | Profit | Orders |
|---|---|---|---|
| West | $240,585 | $34,366 | 695 |
| East | $239,519 | $30,936 | 672 |
| Central | $152,894 | $24,212 | 540 |
| South | $86,733 | $10,804 | 363 |

- **Insight:** West and East drive ~67% of total sales. South is the smallest region by volume — worth investigating whether that's market size or an under-invested territory.

---

### 6. Shipping Behavior
- **68%** of orders use Standard Class shipping (avg. 5.0 days).
- Same Day shipping is rare (115 orders) but near-instant (avg. 0.1 days).
- **Insight:** Most customers are not paying for speed — an opportunity to test upselling faster shipping tiers.

---

### 7. Customer Concentration
- Top customer (Tamara Chand, Corporate segment) alone generated **$18,302** across just 3 orders.
- **Insight:** A small number of high-value customers punch well above average order value — worth a loyalty/account-management approach for top-tier accounts.

---

## How to Use This Section on Your Resume / GitHub
Don't just say "wrote SQL queries." Say what you *found*:
> "Analyzed a 3,000-record retail dataset in MySQL and identified that the Furniture category, despite generating 30% of total revenue, contributed under 6% of total profit — driven by heavy discounting on Tables — and recommended a discount cap to protect margins."

That one sentence shows a recruiter you can turn SQL output into a business decision, which is the actual skill they're screening for.
