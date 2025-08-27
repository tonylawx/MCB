-- MCB Database Migration V5: Insert default category data
-- Provides common income and expense categories for the system

-- Note: This script will be triggered by application code after user registration
-- Here we only create a system default user and categories as examples

-- Create system default user (for demonstration and testing)
INSERT INTO users (email, password_hash) VALUES 
('demo@mcb.com', '$2a$10$dXJ3SW6G7P9wjKe07ygl/.1NJeFO.Em7IdT3Sj7LqJvDj7K8K8sOe'); -- Password: demo123

-- Get the newly created demo user ID (in real applications, this will be handled by application code)
DO $$
DECLARE
    demo_user_id BIGINT;
BEGIN
    SELECT id INTO demo_user_id FROM users WHERE email = 'demo@mcb.com';
    
    -- Insert default expense categories
    INSERT INTO category (name, type, user_id) VALUES
    ('Food & Dining', 'EXPENSE', demo_user_id),
    ('Transportation', 'EXPENSE', demo_user_id),
    ('Shopping', 'EXPENSE', demo_user_id),
    ('Entertainment', 'EXPENSE', demo_user_id),
    ('Healthcare', 'EXPENSE', demo_user_id),
    ('Education', 'EXPENSE', demo_user_id),
    ('Housing', 'EXPENSE', demo_user_id),
    ('Utilities', 'EXPENSE', demo_user_id),
    ('Communication', 'EXPENSE', demo_user_id),
    ('Other Expenses', 'EXPENSE', demo_user_id);
    
    -- Insert default income categories  
    INSERT INTO category (name, type, user_id) VALUES
    ('Salary', 'INCOME', demo_user_id),
    ('Bonus', 'INCOME', demo_user_id),
    ('Investment Income', 'INCOME', demo_user_id),
    ('Side Income', 'INCOME', demo_user_id),
    ('Gift Money', 'INCOME', demo_user_id),
    ('Refunds', 'INCOME', demo_user_id),
    ('Other Income', 'INCOME', demo_user_id);
    
END $$;