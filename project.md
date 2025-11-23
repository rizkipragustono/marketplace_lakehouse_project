# Project Tech Stacks

- docker
- airflow
  - dag generator with jinja templating
  - connect to remote github
- MinIO
- github

- mysql
- postgresql

- parquet
- apache iceberg

- debezium
- kafka
- spark

  - pyspark
  - scala

- dbt
- neo4j
- duckdb

# Project Goals & Use Cases

- End-to-end Data Infrastructure
  - Provision of infrastructure & tools
- Lakehouse Implementation
  - Single lakehouse architecture for batch, streaming, and midpoint for graph data
- Big Data Tools Hands-On Experience
  - Apache Spark
  - Apache Kafka
- Graph Database (Neo4j)
  - modeling:
    - Nodes: Users, Products, Categories, Brands, Reviews.
    - Relationships: (User)-[VIEWED]->(Product), (User)-[BOUGHT]->(Product), (Product)-[BELONGS_TO]->(Category).
  - key use cases:
    - Path-Based Recommendations: Identifying the path a user took to discover a product, such as (User)-[VIEWED]->(Category)-[POPULAR_IN]->(Product).
