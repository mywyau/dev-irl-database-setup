
CREATE TABLE quests (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL UNIQUE,
    client_id VARCHAR(255) NOT NULL,
    dev_id VARCHAR(100),
    rank VARCHAR(50),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    acceptance_criteria TEXT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'NotEstimated',
    tags TEXT[],
    estimated BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (dev_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE dev_bids (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL,
    dev_id VARCHAR(255) NOT NULL,
    dev_username VARCHAR(50) NOT NULL,
    bid  NUMERIC NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE,
    FOREIGN KEY (dev_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE (quest_id, dev_id)
);

CREATE TABLE dev_submissions (
    id BIGSERIAL PRIMARY KEY,
    client_id VARCHAR(255) NOT NULL,
    dev_id VARCHAR(100) NOT NULL,
    quest_id VARCHAR(255) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_type TEXT,
    file_size BIGINT,
    s3_object_key TEXT NOT NULL UNIQUE,
    bucket_name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (dev_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE
);

CREATE TABLE estimation_expiration (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL UNIQUE,
    client_id VARCHAR(255) NOT NULL,
    estimation_close_at TIMESTAMPTZ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE quest_assignment (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL UNIQUE,
    client_id VARCHAR(255) NOT NULL,
    dev_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (dev_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE quest_estimations (
  id BIGSERIAL PRIMARY KEY,
  estimate_id VARCHAR(255) NOT NULL,
  quest_id VARCHAR(255) NOT NULL REFERENCES quests(quest_id) ON DELETE CASCADE,
  dev_id VARCHAR(100) NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  username VARCHAR(50),
  score INT NOT NULL CHECK (score >= 1 AND score <= 100),
  estimated_hours DECIMAL(10,2) CHECK (estimated_hours > 0 AND estimated_hours <= 150),  
  comment TEXT,
  estimation_status VARCHAR(20) DEFAULT 'open',   
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (quest_id, dev_id)                       
);

CREATE TABLE quest_hours (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL,
    client_id VARCHAR(255) NOT NULL,
    hours_of_work NUMERIC NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE (quest_id, client_id) 
);

CREATE TABLE reward (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL,
    client_id VARCHAR(255) NOT NULL,
    dev_id VARCHAR(100),
    time_reward_value NUMERIC,
    completion_reward_value NUMERIC,
    paid VARCHAR(50) DEFAULT 'NotPaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE,
    UNIQUE (quest_id, client_id) 
);
