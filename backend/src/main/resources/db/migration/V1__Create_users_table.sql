-- MCB Database Migration V1: Create users table
-- User registration and authentication information

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes to improve query performance
CREATE UNIQUE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Add table comments
COMMENT ON TABLE users IS 'Users table - stores user registration and authentication information';
COMMENT ON COLUMN users.id IS 'User unique identifier';
COMMENT ON COLUMN users.email IS 'User email address (unique)';
COMMENT ON COLUMN users.password_hash IS 'Password hash value';
COMMENT ON COLUMN users.created_at IS 'Creation timestamp';
COMMENT ON COLUMN users.updated_at IS 'Last update timestamp';