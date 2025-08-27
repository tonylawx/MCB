-- MCB Database Migration V6: Insert sample data (development environment only)
-- Create some sample transaction records for demo user

-- Execute this script only in development environment
-- Please delete this file or configure Flyway profiles for production environment

DO $$
DECLARE
    demo_user_id BIGINT;
    food_category_id BIGINT;
    transport_category_id BIGINT;
    salary_category_id BIGINT;
    shopping_category_id BIGINT;
BEGIN
    -- Get demo user ID
    SELECT id INTO demo_user_id FROM users WHERE email = 'demo@mcb.com';
    
    IF demo_user_id IS NOT NULL THEN
        -- Get category IDs
        SELECT id INTO food_category_id FROM category WHERE user_id = demo_user_id AND name = 'Food & Dining';
        SELECT id INTO transport_category_id FROM category WHERE user_id = demo_user_id AND name = 'Transportation';
        SELECT id INTO salary_category_id FROM category WHERE user_id = demo_user_id AND name = 'Salary';
        SELECT id INTO shopping_category_id FROM category WHERE user_id = demo_user_id AND name = 'Shopping';
        
        -- Insert sample transaction records
        INSERT INTO transaction (
            user_id, category_id, type, amount_minor, currency,
            rate_to_base, amount_base_minor, base_currency,
            occurred_at, note
        ) VALUES
        -- Salary income (CNY)
        (demo_user_id, salary_category_id, 'INCOME', 1500000, 'CNY', 0.1379, 206850, 'USD', '2024-01-01 09:00:00+00', 'January Salary'),
        (demo_user_id, salary_category_id, 'INCOME', 1500000, 'CNY', 0.1379, 206850, 'USD', '2024-02-01 09:00:00+00', 'February Salary'),
        
        -- Food & dining expenses (multi-currency)
        (demo_user_id, food_category_id, 'EXPENSE', 8500, 'CNY', 0.1379, 1172, 'USD', '2024-01-15 12:30:00+00', 'Lunch - Chinese Restaurant'),
        (demo_user_id, food_category_id, 'EXPENSE', 2500, 'USD', 1.0000, 2500, 'USD', '2024-01-20 19:00:00+00', 'Dinner - Western Restaurant'),
        (demo_user_id, food_category_id, 'EXPENSE', 4500, 'CAD', 0.7407, 3333, 'USD', '2024-01-25 18:30:00+00', 'Dinner - Canadian Restaurant'),
        
        -- Transportation expenses
        (demo_user_id, transport_category_id, 'EXPENSE', 50000, 'CNY', 0.1379, 6895, 'USD', '2024-01-10 08:00:00+00', 'Monthly Metro Card'),
        (demo_user_id, transport_category_id, 'EXPENSE', 3500, 'USD', 1.0000, 3500, 'USD', '2024-01-16 14:00:00+00', 'Taxi'),
        
        -- Shopping expenses
        (demo_user_id, shopping_category_id, 'EXPENSE', 25000, 'CNY', 0.1379, 3448, 'USD', '2024-01-18 16:00:00+00', 'Clothing Purchase'),
        (demo_user_id, shopping_category_id, 'EXPENSE', 15000, 'CAD', 0.7407, 11111, 'USD', '2024-01-22 10:00:00+00', 'Electronics');
        
    END IF;
END $$;

-- Add more historical exchange rate data (for testing)
INSERT INTO exchange_rate (base, quote, rate, as_of) VALUES
-- Historical exchange rate data
('USD', 'CNY', 7.1800, '2024-01-01 00:00:00+00'),
('USD', 'CNY', 7.2200, '2024-01-15 00:00:00+00'),
('USD', 'CAD', 1.3400, '2024-01-01 00:00:00+00'),
('USD', 'CAD', 1.3600, '2024-01-15 00:00:00+00'),
('CNY', 'USD', 0.1393, '2024-01-01 00:00:00+00'),
('CAD', 'USD', 0.7463, '2024-01-01 00:00:00+00');