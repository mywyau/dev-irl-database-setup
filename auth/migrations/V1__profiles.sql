DROP TABLE IF EXISTS outbox_events;

CREATE TABLE IF NOT EXISTS outbox_events (
  id BIGSERIAL PRIMARY KEY,
  event_id VARCHAR(255),
  aggregate_type VARCHAR(100) NOT NULL,
  aggregate_id VARCHAR(255) NOT NULL,
  event_type VARCHAR(100) NOT NULL,
  payload JSONB NOT NULL,
  published BOOLEAN NOT NULL DEFAULT FALSE,
  retry_count INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
)