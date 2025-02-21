
DROP TABLE IF EXISTS user_address;

CREATE TABLE user_address (
    id BIGSERIAL PRIMARY KEY,
    user_id VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255),
    county VARCHAR(255),
    postcode VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS user_personal_details;

CREATE TABLE user_personal_details (
    id BIGSERIAL PRIMARY KEY,
    user_id VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    contact_number VARCHAR(100),
    company VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
