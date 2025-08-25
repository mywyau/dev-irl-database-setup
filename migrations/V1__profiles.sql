DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS quests;
DROP TABLE IF EXISTS dev_bids;
DROP TABLE IF EXISTS dev_submissions;
DROP TABLE IF EXISTS estimation_expiration;
DROP TABLE IF EXISTS language;
DROP TABLE IF EXISTS quest_assignment;
DROP TABLE IF EXISTS quest_estimations;
DROP TABLE IF EXISTS quest_hours;
DROP TABLE IF EXISTS reward;
DROP TABLE IF EXISTS skill;
DROP TABLE IF EXISTS stripe_accounts;

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    user_id VARCHAR(100) UNIQUE,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    mobile VARCHAR(50),
    user_type VARCHAR(50) CHECK (user_type IN ('Client', 'Dev', 'UnknownUserType')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stripe_accounts (
  id BIGSERIAL PRIMARY KEY,
  user_id VARCHAR(100) UNIQUE NOT NULL,
  stripe_account_id VARCHAR(255) NOT NULL UNIQUE,
  onboarded BOOLEAN DEFAULT FALSE,
  charges_enabled BOOLEAN DEFAULT FALSE,
  payouts_enabled BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dev_skills (
  id BIGSERIAL PRIMARY KEY,
  dev_id VARCHAR(100),
  username VARCHAR(50),
  skill VARCHAR(255),
  level INT NOT NULL DEFAULT 1 CHECK (level >= 1 AND level <= 99),
  xp DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  next_level INT,
  next_level_xp DECIMAL(10, 2),
  CONSTRAINT unique_dev_skill UNIQUE (dev_id, skill),
  FOREIGN KEY (dev_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE dev_languages (
  id BIGSERIAL PRIMARY KEY,
  dev_id VARCHAR(100),
  username VARCHAR(50),
  language VARCHAR(255),
  level INT NOT NULL DEFAULT 1 CHECK (level >= 1 AND level <= 99),
  xp DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  next_level INT,
  next_level_xp DECIMAL(10, 2),
  CONSTRAINT unique_dev_language UNIQUE (dev_id, language),
  FOREIGN KEY (dev_id) REFERENCES users(user_id) ON DELETE CASCADE
);

