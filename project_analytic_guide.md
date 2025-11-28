# Market Place Lakehouse & Graph Project Guide

## Project Overview

This project simulates a modern data platform that serves two distinct needs:

1. Lakehouse (OLAP): Aggregated reporting on revenue, ad spend, and conversion rates.
2. Graph (Network Analysis): Analyzing user journeys, attribution paths, and recommendation engines.

## The Dataset (Raw Files)

### Core Entities

- `users.csv`: Registered user profiles.
- `brands.csv` & categories.csv: Dimension tables for product classification.
- `products.csv`: The inventory catalog linked to Brands and Categories.

### Event Streams (The "Fact" Tables)

- `behavior_logs.csv`: The raw clickstream.
  - Key Columns: `user_id`, `product_id`, `event_type` (VIEWED, ADD_TO_CART, BOUGHT), `session_id`.
  - Purpose: Tracks the sequence of actions a user takes.
- `campaign_events.csv`: Marketing attribution data.
  - Key Columns: `campaign_id`, `session_id`, `source_url`, `cost_per_click`.
  - Purpose: Links a user's web session to the specific ad that brought them there.
- `reviews.csv`: Post-purchase sentiment data.

## Part A: Lakehouse Analytics (SQL)

_Focus: Aggregations, Totals, and KPIs._

In this layer, you ingest the CSVs into tables and perform joins to answer "How much?" and "How many?".

### Key Metrics to Calculate

1. ROAS (Return on Ad Spend): Join `campaign_events` (cost) with `behavior_logs` (revenue) on `session_id`.
2. Conversion Rate: Count unique sessions with a `BOUGHT` event divided by total sessions.

**Example SQL: Campaign Performance**

```
SELECT
    c.campaign_name,
    COUNT(DISTINCT ce.click_id) as clicks,
    SUM(ce.cost_per_click) as total_cost,
    SUM(CASE WHEN b.event_type = 'BOUGHT'
        THEN p.price
        ELSE 0 END) as attributed_revenue
FROM campaigns c
JOIN campaign_events ce
    ON c.campaign_id = ce.campaign_id
JOIN behavior_logs b
    ON ce.session_id = b.session_id
JOIN products p
    ON b.product_id = p.product_id
GROUP BY c.campaign_name;
```

## Part B: Graph Analytics (Path-Based Recommendations)

_Focus: Journeys, Influence, and Connections._

In this layer, you load the data as Nodes and Relationships to answer "How?" and "Why?".

**The Graph Schema**

- Nodes: `(:User)`, `(:Product)`, `(:Category)`, `(:Brand)`, `(:Campaign)`
- Relationships:
  - `(User)-[:ARRIVED_VIA]->(Campaign)`
  - `(User)-[:VIEWED]->(Product)`
  - `(User)-[:BOUGHT]->(Product)`
  - `(Product)-[:BELONGS_TO]->(Category)`

## Deep Dive: The 3 Analytical Paths

**Path 1: The "Marketing Influence" Path (Attribution)**

The Concept: Identifying campaigns that act as "Hooks." A user clicks an ad for Product X but buys Product Y. Standard analytics might count this as a failure for the ad, but Graph shows the influence.

- The Path: `(Campaign) <-[:ARRIVED_VIA]- (User) -[:BOUGHT]-> (Product)`
- Cypher Query:

```// Find what people actually buy after clicking specific campaigns
MATCH (c:Campaign)<-[:ARRIVED_VIA]-(u:User)-[:BOUGHT]->(p:Product)
RETURN c.name AS Ad_Source, p.product_name AS Actually_Bought, count(\*) as volume
ORDER BY volume DESC;
```

**Path 2: The "Bait & Switch" Journey (Upsell/Downsell)**

The Concept: Understanding the relationship between what users dream about versus what they afford.

- The Path: `(User) -[:VIEWED]-> (Product A) ... then ... (User) -[:BOUGHT]-> (Product B)`
- Business Value: If users frequently view a $1000 item but buy a $500 item, you should explicitly recommend the $500 item on the $1000 item's page as a "Budget Alternative."
- Cypher Query:

```
MATCH (u:User)-[:VIEWED]->(viewed:Product)
MATCH (u)-[:BOUGHT]->(bought:Product)
WHERE viewed.price > bought.price AND viewed <> bought
RETURN viewed.product_name AS High_End_View, bought.product_name AS Budget_Choice
```

**Path 3: Semantic Discovery (Cold Start)**

The Concept: Making recommendations for a user with almost no history. We rely on the "Semantic" connections of the product graph.

- The Path: `(User) -[:VIEWED]-> (Product A) -[:BELONGS_TO]-> (Brand) <-[:BELONGS_TO]- (Product B)`
- Business Value: Recommending items that are structurally related (same Brand, same Category) rather than behaviorally related (other people bought).
- Cypher Query:

```
MATCH (u:User {id: 'U005'})-[:VIEWED]->(p:Product)-[:BELONGS_TO]->(b:Brand)<-[:BELONGS_TO]-(rec:Product)
WHERE NOT (u)-[:VIEWED]->(rec)
RETURN rec.product_name, b.brand_name
LIMIT 5;
```
