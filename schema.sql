-- Create enums
CREATE TYPE package_size AS ENUM ('small', 'medium', 'large');
CREATE TYPE delivery_status AS ENUM ('requested', 'accepted', 'picked', 'delivered');
CREATE TYPE user_role AS ENUM ('sender', 'carrier', 'both');

-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role user_role NOT NULL DEFAULT 'both',
    rating INTEGER,
    total_reviews INTEGER DEFAULT 0
);

-- Create deliveries table
CREATE TABLE deliveries (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER NOT NULL REFERENCES users(id),
    carrier_id INTEGER REFERENCES users(id),
    pickup_location TEXT NOT NULL,
    drop_location TEXT NOT NULL,
    package_size package_size NOT NULL,
    package_weight INTEGER NOT NULL,
    description TEXT,
    special_instructions TEXT,
    preferred_delivery_date TEXT NOT NULL,
    preferred_delivery_time TEXT NOT NULL,
    status delivery_status NOT NULL DEFAULT 'requested',
    delivery_fee INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- Create reviews table
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    delivery_id INTEGER NOT NULL REFERENCES deliveries(id),
    reviewer_id INTEGER NOT NULL REFERENCES users(id),
    reviewee_id INTEGER NOT NULL REFERENCES users(id),
    rating INTEGER NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL
); 