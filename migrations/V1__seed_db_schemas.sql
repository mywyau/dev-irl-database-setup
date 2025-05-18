DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS quests;
DROP TABLE IF EXISTS quest_progress;
DROP TABLE IF EXISTS bounty;

CREATE TABLE users (
    id UUID PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quests table
CREATE TABLE quests (
    id BIGSERIAL PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    quest_id VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'NotStarted',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TODO: suggested improvements
-- CREATE TABLE quests (
--     id BIGSERIAL PRIMARY KEY,
--     client_id UUID NOT NULL REFERENCES users(id), -- who posted the quest
--     title VARCHAR(255) NOT NULL,
--     description TEXT NOT NULL,
--     status VARCHAR(50) NOT NULL DEFAULT 'open', -- open | claimed | completed
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );


CREATE TABLE quest_claims (
    id BIGSERIAL PRIMARY KEY,
    quest_id BIGINT NOT NULL REFERENCES quests(id),
    user_id UUID NOT NULL REFERENCES users(id), -- the contributor
    status VARCHAR(50) NOT NULL DEFAULT 'active', -- active | submitted | approved | abandoned
    submitted_at TIMESTAMP,
    completed_at TIMESTAMP
);


-- Bounty table
CREATE TABLE bounty (
    id BIGSERIAL PRIMARY KEY,
    quest_id BIGINT NOT NULL REFERENCES quests(id),
    base_reward NUMERIC NOT NULL,
    time_reward NUMERIC NOT NULL,
    success_reward NUMERIC NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE rewards (
    id BIGSERIAL PRIMARY KEY,
    quest_id BIGINT NOT NULL REFERENCES quests(id),
    user_id UUID NOT NULL REFERENCES users(id),
    amount NUMERIC NOT NULL,
    claimed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);