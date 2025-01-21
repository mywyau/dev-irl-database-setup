DROP TABLE IF EXISTS desk_pricing;
DROP TABLE IF EXISTS desk_specifications;

-- Desk Specifications Table
CREATE TABLE desk_specifications (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255),
    business_id VARCHAR(255),
    office_id VARCHAR(255),
    desk_id VARCHAR(255) UNIQUE,
    desk_name VARCHAR(50),
    description TEXT,
    desk_type VARCHAR(100),
    quantity INT CHECK (quantity >= 0),
    features TEXT[],
    availability JSONB,
    rules TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_business_specifications_spec
        FOREIGN KEY (business_id)
        REFERENCES business_specifications(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_address_spec
        FOREIGN KEY (business_id)
        REFERENCES business_address(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_contact_spec
        FOREIGN KEY (business_id)
        REFERENCES business_contact_details(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_office_address_spec
        FOREIGN KEY (office_id)
        REFERENCES office_address(office_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_office_contact_details_spec
        FOREIGN KEY (office_id)
        REFERENCES office_contact_details(office_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_office_specifications_spec
        FOREIGN KEY (office_id)
        REFERENCES office_specifications(office_id)
        ON DELETE CASCADE
);

-- Desk Pricing Table
CREATE TABLE desk_pricing (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255),
    business_id VARCHAR(255),
    office_id VARCHAR(255),
    desk_id VARCHAR(255) UNIQUE,
    price_per_hour DECIMAL(10, 2) CHECK (price_per_hour >= 0),
    price_per_day DECIMAL(10, 2) CHECK (price_per_day >= 0),
    price_per_week DECIMAL(10, 2) CHECK (price_per_week >= 0),
    price_per_month DECIMAL(10, 2) CHECK (price_per_month >= 0),
    price_per_year DECIMAL(10, 2) CHECK (price_per_year >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_business_specifications_pricing
        FOREIGN KEY (business_id)
        REFERENCES business_specifications(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_address_pricing
        FOREIGN KEY (business_id)
        REFERENCES business_address(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_contact_pricing
        FOREIGN KEY (business_id)
        REFERENCES business_contact_details(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_office_address_pricing
        FOREIGN KEY (office_id)
        REFERENCES office_address(office_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_office_contact_details_pricing
        FOREIGN KEY (office_id)
        REFERENCES office_contact_details(office_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_office_specifications_pricing
        FOREIGN KEY (office_id)
        REFERENCES office_specifications(office_id)
        ON DELETE CASCADE
);
