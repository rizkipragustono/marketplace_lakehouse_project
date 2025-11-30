CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150),
    country VARCHAR(50),
    created_at DATETIME
);

CREATE TABLE IF NOT EXISTS brands (
    brand_id VARCHAR(50) PRIMARY KEY,
    brand_name VARCHAR(100),
    headquarters VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS categories (
    category_id VARCHAR(50) PRIMARY KEY,
    category_name VARCHAR(100),
    parent_category_id VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(150),
    brand_id VARCHAR(50),
    category_id VARCHAR(50),
    price DECIMAL(10, 2),
    stock_level INT,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE IF NOT EXISTS behavior_logs (
    event_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50),
    product_id VARCHAR(50),
    event_type VARCHAR(50),
    timestamp DATETIME,
    session_id VARCHAR(50),
    device VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50),
    product_id VARCHAR(50),
    rating INT,
    comment TEXT,
    review_date DATE
);

CREATE TABLE IF NOT EXISTS campaigns (
    campaign_id VARCHAR(50) PRIMARY KEY,
    campaign_name VARCHAR(100),
    channel VARCHAR(50),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2),
    target_audience VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS campaign_events (
    click_id VARCHAR(50) PRIMARY KEY,
    campaign_id VARCHAR(50),
    user_id VARCHAR(50),
    session_id VARCHAR(50),
    timestamp DATETIME,
    cost_per_click DECIMAL(10, 2),
    source_url VARCHAR(255)
);