-- MCB Database Migration V4: Create transaction table
-- Core transaction data supporting multi-currency accounting

CREATE TABLE transaction (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('INCOME', 'EXPENSE')),
    
    -- Original amount information
    amount_minor BIGINT NOT NULL,
    currency VARCHAR(3) NOT NULL,
    
    -- Conversion to base currency information
    rate_to_base DECIMAL(20, 8) NOT NULL,
    amount_base_minor BIGINT NOT NULL,
    base_currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    
    -- Time and notes
    occurred_at TIMESTAMP WITH TIME ZONE NOT NULL,
    note TEXT,
    
    -- Audit fields
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_transaction_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_transaction_category FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE RESTRICT,
    
    -- Constraint conditions
    CONSTRAINT chk_transaction_amount_positive CHECK (amount_minor > 0),
    CONSTRAINT chk_transaction_amount_base_positive CHECK (amount_base_minor > 0),
    CONSTRAINT chk_transaction_rate_positive CHECK (rate_to_base > 0),
    CONSTRAINT chk_transaction_currency_format CHECK (
        currency ~ '^[A-Z]{3}$' AND base_currency ~ '^[A-Z]{3}$'
    )
);

-- Create indexes to improve query performance
CREATE INDEX idx_transaction_user_id ON transaction(user_id);
CREATE INDEX idx_transaction_category_id ON transaction(category_id);
CREATE INDEX idx_transaction_type ON transaction(type);
CREATE INDEX idx_transaction_occurred_at ON transaction(occurred_at);
CREATE INDEX idx_transaction_currency ON transaction(currency);
CREATE INDEX idx_transaction_user_occurred ON transaction(user_id, occurred_at);
CREATE INDEX idx_transaction_user_type ON transaction(user_id, type);

-- Report query indexes (temporarily remove function indexes, optimize later)
-- CREATE INDEX idx_transaction_user_month ON transaction(user_id, date_trunc('month', occurred_at));

-- Add table comments
COMMENT ON TABLE transaction IS 'Transaction table - core transaction data supporting multi-currency';
COMMENT ON COLUMN transaction.id IS 'Transaction record unique identifier';
COMMENT ON COLUMN transaction.user_id IS 'Owner user ID';
COMMENT ON COLUMN transaction.category_id IS 'Category ID';
COMMENT ON COLUMN transaction.type IS 'Transaction type: INCOME (income) or EXPENSE (expense)';
COMMENT ON COLUMN transaction.amount_minor IS 'Original amount (smallest currency unit, e.g., cents)';
COMMENT ON COLUMN transaction.currency IS 'Original currency code';
COMMENT ON COLUMN transaction.rate_to_base IS 'Exchange rate to base currency';
COMMENT ON COLUMN transaction.amount_base_minor IS 'Base currency amount (smallest unit)';
COMMENT ON COLUMN transaction.base_currency IS 'Base currency code (default USD)';
COMMENT ON COLUMN transaction.occurred_at IS 'Transaction occurrence time';
COMMENT ON COLUMN transaction.note IS 'Transaction note';
COMMENT ON COLUMN transaction.created_at IS 'Record creation timestamp';
COMMENT ON COLUMN transaction.updated_at IS 'Last update timestamp';