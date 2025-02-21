-- Drop existing tables if they exist
DROP TABLE IF EXISTS office_contact_details;
DROP TABLE IF EXISTS office_address;
DROP TABLE IF EXISTS office_specifications;

-- Office Contact Details Table
CREATE TABLE office_contact_details (
    id BIGSERIAL PRIMARY KEY,
    business_id VARCHAR(255) NOT NULL,
    office_id VARCHAR(255) NOT NULL UNIQUE,
    primary_contact_first_name VARCHAR(255),
    primary_contact_last_name VARCHAR(255),
    contact_email VARCHAR(255),
    contact_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_business_spec_contact
        FOREIGN KEY (business_id)
        REFERENCES business_specifications(business_id)
        ON DELETE CASCADE,    
    CONSTRAINT fk_business_address_contact
        FOREIGN KEY (business_id)
        REFERENCES business_address(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_contact_details_contact
        FOREIGN KEY (business_id)
        REFERENCES business_contact_details(business_id)
        ON DELETE CASCADE
);

-- Office Address Table
CREATE TABLE office_address (
    id BIGSERIAL PRIMARY KEY,
    business_id VARCHAR(255) NOT NULL,
    office_id VARCHAR(255) NOT NULL UNIQUE,
    building_name VARCHAR(255),
    floor_number VARCHAR(50),
    street VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255),
    county VARCHAR(255),
    postcode VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_business_spec_address
        FOREIGN KEY (business_id)
        REFERENCES business_specifications(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_address_address
        FOREIGN KEY (business_id)
        REFERENCES business_address(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_contact_details_address
        FOREIGN KEY (business_id)
        REFERENCES business_contact_details(business_id)
        ON DELETE CASCADE
);

-- Office Specifications Table
CREATE TABLE office_specifications (
    id SERIAL PRIMARY KEY,
    business_id VARCHAR(255) NOT NULL,
    office_id VARCHAR(255) NOT NULL UNIQUE,
    office_name VARCHAR(255),
    description TEXT,
    office_type VARCHAR(100),
    number_of_floors INT,
    total_desks INT,
    capacity INT,
    amenities TEXT[],
    -- opening_hours JSONB,
    rules TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_business_spec_spec
        FOREIGN KEY (business_id)
        REFERENCES business_specifications(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_address_spec
        FOREIGN KEY (business_id)
        REFERENCES business_address(business_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_business_contact_details_spec
        FOREIGN KEY (business_id)
        REFERENCES business_contact_details(business_id)
        ON DELETE CASCADE
);
