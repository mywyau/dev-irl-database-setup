DROP TABLE IF EXISTS pricing_plans;
DROP TABLE IF EXISTS user_plans;
DROP TABLE IF EXISTS stripe_accounts;

CREATE TABLE IF NOT EXISTS pricing_plans (
    id BIGSERIAL PRIMARY KEY,
    plan_id VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    stripe_price_id VARCHAR(100),
    features JSONB DEFAULT '{}'::jsonb,
    price NUMERIC NOT NULL DEFAULT 0.00,
    interval VARCHAR(20) DEFAULT 'month',
    user_type VARCHAR(50) CHECK (user_type IN ('Client', 'Freelancer', 'Admin', 'NoUserType', 'UnknownUserType')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_plans (
    id BIGSERIAL PRIMARY KEY,
    user_id VARCHAR(100) UNIQUE NOT NULL,
    plan_id VARCHAR(100) NOT NULL,
    stripe_subscription_id VARCHAR(255),
    stripe_customer_id VARCHAR(255),
    status VARCHAR(50) NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    current_period_end TIMESTAMPTZ,
    cancel_at_period_end BOOLEAN DEFAULT FALSE,
    last_synced_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_plan FOREIGN KEY (plan_id) REFERENCES pricing_plans(plan_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS stripe_accounts (
  id BIGSERIAL PRIMARY KEY,
  user_id VARCHAR(100) UNIQUE NOT NULL,
  stripe_account_id VARCHAR(255) NOT NULL UNIQUE,
  onboarded BOOLEAN DEFAULT FALSE,
  charges_enabled BOOLEAN DEFAULT FALSE,
  payouts_enabled BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Seed pricing plans (idempotent)
INSERT INTO pricing_plans (
  plan_id,
  name,
  description,
  stripe_price_id,
  features,
  price,
  interval,
  user_type
) VALUES
  -- CLIENT
  ('PLAN001','ClientFree','Free plan', NULL,
    jsonb_build_object(
      'maxActiveQuests', 2,
      'FreelancerPool', 'auto',
      'estimations', true,
      'canCustomizeLevelThresholds', false,
      'boostQuests', false
    )::jsonb,
    0.00,'month', 'Client'
  ),
  ('PLAN002','ClientStarter','Starter plan', 'price_1RxYV509eXrPaQIgAdMavMwB',
    jsonb_build_object(
      'maxActiveQuests', 5,
      'FreelancerPool', 'invite',
      'estimations', true,
      'canCustomizeLevelThresholds', false,
      'boostQuests', false
    )::jsonb,
    30.00,'month', 'Client'
  ),
  ('PLAN003','ClientGrowth','Growth plan', 'price_1RxYWG09eXrPaQIgLCQ4zaVC',
    jsonb_build_object(
      'maxActiveQuests', 20,
      'FreelancerPool', 'invite',
      'estimations', true,
      'canCustomizeLevelThresholds', true,
      'boostQuests', true
    )::jsonb,
    60.00,'month', 'Client'
  ),
  ('PLAN004','ClientScale','Scale plan', 'price_1RxYWl09eXrPaQIgLcufIvaD',
    jsonb_build_object(
      'maxActiveQuests', 999999999,   -- effectively "Unlimited"
      'FreelancerPool', 'invite',
      'estimations', true,
      'canCustomizeLevelThresholds', true,
      'boostQuests', true
    )::jsonb,
    80.00,'month', 'Client'
  ),

  -- Freelancer
  ('PLAN006','FreelancerFree','Freelancer free', NULL,
    jsonb_build_object(
      'maxActiveQuests', 1,
      'showOnLeaderBoard', false,
      'communicateWithClient', false
    )::jsonb,
    0.00,'month', 'Freelancer'
  ),
  ('PLAN007','Freelancer Basic','Freelancer basic', 'price_1RxYXS09eXrPaQIgHNNfOnMG',  -- this stripe id is test only for now 
    jsonb_build_object(
      'maxActiveQuests', 5,
      'showOnLeaderBoard', true,
      'communicateWithClient', true
    )::jsonb,
    20.00,'month', 'Freelancer'
  ),
  ('PLAN008','FreelancerPro','Freelancer pro', 'price_1RxYXm09eXrPaQIgbZQwCxd3',
    jsonb_build_object(
      'maxActiveQuests', 10,
      'showOnLeaderBoard', true,
      'communicateWithClient', true
    )::jsonb,
    40.00,'month', 'Freelancer'
  )
ON CONFLICT (plan_id) DO UPDATE SET
  name            = EXCLUDED.name,
  description     = EXCLUDED.description,
  stripe_price_id = EXCLUDED.stripe_price_id,
  features        = EXCLUDED.features,
  price           = EXCLUDED.price,
  interval        = EXCLUDED.interval,
  user_type       = EXCLUDED.user_type;
