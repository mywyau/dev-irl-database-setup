DROP TABLE IF EXISTS desk_listings;

CREATE TABLE desk_listings (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255),
    business_id VARCHAR(255),
    office_id VARCHAR(255),
    desk_id VARCHAR(255) UNIQUE,
    desk_name VARCHAR(50),
    description TEXT,
    desk_type VARCHAR(100),
    quantity INT NOT NULL CHECK (quantity >= 0),
    features TEXT[],
    availability JSONB,
    rules TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE desk_pricing (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255),
    business_id VARCHAR(255),
    office_id VARCHAR(255),
    desk_id VARCHAR(255) UNIQUE,
    price_per_hour DECIMAL(10, 2) CHECK (price_per_hour >= 0),
    price_per_day DECIMAL(10, 2) CHECK (price_per_day >= 0),
    price_per_week DECIMAL(10, 2) CHECK (price_per_week >= 0),
    price_per_month DECIMAL(10, 2) CHECK (price_per_month >= 0),
    price_per_year DECIMAL(10, 2) CHECK (price_per_year >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);