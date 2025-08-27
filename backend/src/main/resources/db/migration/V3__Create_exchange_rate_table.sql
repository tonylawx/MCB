-- MCB Database Migration V3: Create exchange rate table
-- Multi-currency exchange rate conversion information

CREATE TABLE exchange_rate (
    id BIGSERIAL PRIMARY KEY,
    base VARCHAR(3) NOT NULL,
    quote VARCHAR(3) NOT NULL, 
    rate DECIMAL(20, 8) NOT NULL,
    as_of TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraint conditions
    CONSTRAINT chk_exchange_rate_positive CHECK (rate > 0),
    CONSTRAINT chk_exchange_rate_currency_format CHECK (
        base ~ '^[A-Z]{3}$' AND quote ~ '^[A-Z]{3}$'
    )
);

-- Create indexes
CREATE INDEX idx_exchange_rate_base_quote ON exchange_rate(base, quote);
CREATE INDEX idx_exchange_rate_as_of ON exchange_rate(as_of);
CREATE UNIQUE INDEX idx_exchange_rate_base_quote_as_of ON exchange_rate(base, quote, as_of);

-- Add table comments
COMMENT ON TABLE exchange_rate IS 'Exchange rate table - stores currency exchange rate information';
COMMENT ON COLUMN exchange_rate.id IS 'Exchange rate record unique identifier';
COMMENT ON COLUMN exchange_rate.base IS 'Base currency code (e.g., USD, CNY, CAD)';
COMMENT ON COLUMN exchange_rate.quote IS 'Target currency code';
COMMENT ON COLUMN exchange_rate.rate IS 'Exchange rate value (precise to 8 decimal places)';
COMMENT ON COLUMN exchange_rate.as_of IS 'Exchange rate effective time';
COMMENT ON COLUMN exchange_rate.created_at IS 'Record creation timestamp';

-- Insert some basic exchange rate data (for development environment)
INSERT INTO exchange_rate (base, quote, rate, as_of) VALUES
('USD', 'CNY', 7.2500, CURRENT_TIMESTAMP),
('USD', 'CAD', 1.3500, CURRENT_TIMESTAMP),
('CNY', 'USD', 0.1379, CURRENT_TIMESTAMP),
('CAD', 'USD', 0.7407, CURRENT_TIMESTAMP),
('CAD', 'CNY', 5.3704, CURRENT_TIMESTAMP),
('CNY', 'CAD', 0.1862, CURRENT_TIMESTAMP);