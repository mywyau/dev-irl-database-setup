-- Drop the reviews table if it exists (for reinitialization)

DROP TABLE IF EXISTS user_login_details;

CREATE TABLE user_login_details (
    id BIGSERIAL PRIMARY KEY UNIQUE,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'Wanderer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
