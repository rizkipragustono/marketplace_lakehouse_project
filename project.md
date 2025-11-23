# Project Tech Stacks

- docker
- mysql
- MinIO
- ELT
- parquet
- duckdb
- apache iceberg?
- spark
  - pyspark
  - scala
- dbt
- neo4j
- github
- airflow
  - dag generator with jinja templating
  - connect to remote github

<!-- - infrastructure as a code -->

# Project Use Cases

- Lakehouse implementation
  - single lakehouse architecture for batch, streaming, and midpoint for graph data
- Graph Database (Neo4j)
  - modeling:
    - Nodes: Users, Products, Categories, Brands, Reviews.
    - Relationships: (User)-[VIEWED]->(Product), (User)-[BOUGHT]->(Product), (Product)-[BELONGS_TO]->(Category).
  - key use cases:
    - Path-Based Recommendations: Identifying the path a user took to discover a product, such as (User)-[VIEWED]->(Category)-[POPULAR_IN]->(Product).
