
CREATE TABLE business_opening_hours (
      id BIGSERIAL PRIMARY KEY UNIQUE,
      user_id VARCHAR(255) NOT NULL,
      business_id VARCHAR(255) NOT NULL,
      weekday VARCHAR(10) NOT NULL CHECK (weekday IN 
      ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),                            
      opening_time VARCHAR(5),                            
      closing_time VARCHAR(5),                            
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      UNIQUE (business_id, weekday) -- Prevents duplicate weekdays per business
);


CREATE TABLE office_opening_hours (
      id BIGSERIAL PRIMARY KEY UNIQUE,
      user_id VARCHAR(255) NOT NULL,
      business_id VARCHAR(255) NOT NULL,
      weekday VARCHAR(10) NOT NULL CHECK (weekday IN 
      ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),                            
      opening_time VARCHAR(5),                            
      closing_time VARCHAR(5),                            
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      UNIQUE (business_id, weekday) -- Prevents duplicate weekdays per business
);


CREATE TABLE desk_opening_hours (
      id BIGSERIAL PRIMARY KEY UNIQUE,
      user_id VARCHAR(255) NOT NULL,
      business_id VARCHAR(255) NOT NULL,
      weekday VARCHAR(10) NOT NULL CHECK (weekday IN 
      ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),                            
      opening_time VARCHAR(5),                            
      closing_time VARCHAR(5),                            
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      UNIQUE (business_id, weekday) -- Prevents duplicate weekdays per business
);
