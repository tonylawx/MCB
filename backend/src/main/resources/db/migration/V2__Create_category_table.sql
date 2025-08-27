-- MCB Database Migration V2: Create category table
-- Income and expense category management

CREATE TABLE category (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('INCOME', 'EXPENSE')),
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_category_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create indexes
CREATE INDEX idx_category_user_id ON category(user_id);
CREATE INDEX idx_category_type ON category(type);
CREATE UNIQUE INDEX idx_category_user_name_type ON category(user_id, name, type);

-- Add table comments
COMMENT ON TABLE category IS 'Category table - stores income and expense category information';
COMMENT ON COLUMN category.id IS 'Category unique identifier';
COMMENT ON COLUMN category.name IS 'Category name';
COMMENT ON COLUMN category.type IS 'Category type: INCOME (income) or EXPENSE (expense)';
COMMENT ON COLUMN category.user_id IS 'Owner user ID';
COMMENT ON COLUMN category.created_at IS 'Creation timestamp';
COMMENT ON COLUMN category.updated_at IS 'Last update timestamp';