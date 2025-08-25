-- migrations/V2__quest_search.sql

--  read model 

DROP TABLE IF EXISTS quest_view;

-- Enable useful extensions (safe to run if not already enabled)
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS btree_gin;

-- 1) Global, cacheable view of each quest (1 row per quest)
CREATE TABLE IF NOT EXISTS quest_view (
  quest_id                 VARCHAR(255) PRIMARY KEY,
  client_id                VARCHAR(255) NOT NULL,
  title                    VARCHAR(255) NOT NULL,
  rank                     VARCHAR(50),
  status                   VARCHAR(50) NOT NULL,
  tags                     TEXT[],
  created_at               TIMESTAMP NOT NULL,
  updated_at               TIMESTAMP NOT NULL,
  last_activity_at         TIMESTAMP NOT NULL,
  estimation_close_at      TIMESTAMPTZ,

  -- Aggregates to show/filter/sort on the list
  job_quotes_count         INT DEFAULT 0,
  min_job_quote            NUMERIC,
  max_job_quote            NUMERIC,

  estimates_count          INT DEFAULT 0,
  avg_estimated_hours      DECIMAL(10,2),

  submissions_count        INT DEFAULT 0,
  assigned_dev_id          VARCHAR(100),
  assigned_dev_username    VARCHAR(50),

  reward_time_total        NUMERIC,
  reward_completion_total  NUMERIC,

  -- Search helpers
  title_tsv                tsvector,

  -- Version guards per source (for out-of-order events)
  quests_v                 BIGINT DEFAULT 0,
  bids_v                   BIGINT DEFAULT 0,
  estimates_v              BIGINT DEFAULT 0,
  rewards_v                BIGINT DEFAULT 0,
  submissions_v            BIGINT DEFAULT 0,
  assignment_v             BIGINT DEFAULT 0,
  expiration_v             BIGINT DEFAULT 0
);

-- 2) Per-user personalization (keep sparse to stay fast)
CREATE TABLE IF NOT EXISTS quest_user_view (
  quest_id                VARCHAR(255) NOT NULL,
  user_id                 VARCHAR(100) NOT NULL,
  has_user_bid            BOOLEAN DEFAULT FALSE,
  user_bid                NUMERIC,
  has_user_estimated      BOOLEAN DEFAULT FALSE,
  user_estimated_hours    DECIMAL(10,2),
  PRIMARY KEY (quest_id, user_id)
);

