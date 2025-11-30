
CREATE TABLE quests (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL UNIQUE,
    client_id VARCHAR(255) NOT NULL,
    freelancer_id VARCHAR(100),
    rank VARCHAR(50),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    acceptance_criteria TEXT NOT NULL,        
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -- FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    -- FOREIGN KEY (freelancer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
    notification_id VARCHAR(255) NOT NULL UNIQUE,
    client_id VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    event_type VARCHAR(100) NOT NULL,
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE freelancer_bids (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL,
    freelancer_id VARCHAR(255) NOT NULL,
    freelancer_username VARCHAR(50) NOT NULL,
    bid  NUMERIC NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE,
    FOREIGN KEY (freelancer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE (quest_id, freelancer_id)
);

CREATE TABLE freelancer_submissions (
    id BIGSERIAL PRIMARY KEY,
    client_id VARCHAR(255) NOT NULL,
    freelancer_id VARCHAR(100) NOT NULL,
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
    FOREIGN KEY (freelancer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE
);


CREATE TABLE reward (
    id BIGSERIAL PRIMARY KEY,
    quest_id VARCHAR(255) NOT NULL,
    client_id VARCHAR(255) NOT NULL,
    freelancer_id VARCHAR(100),
    time_reward_value NUMERIC,
    completion_reward_value NUMERIC,
    paid VARCHAR(50) DEFAULT 'NotPaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE,
    UNIQUE (quest_id, client_id) 
);
