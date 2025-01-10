-- Insert test data into user_login_details
INSERT INTO user_login_details (user_id, email, password_hash, role, created_at, updated_at)
VALUES
('user-001', 'jdoe@example.com', '$2b$10$ABCDEFGHIJKLMNOPQRSTUVWX/abcdefghijklmnopqrstuvwx', 'Wanderer',  '2023-01-01 12:00:00', '2023-01-01 12:00:00'),
('user-002', 'asmith@example.com', '$2b$10$ABCDEFGHIJKLMNOPQRSTUVWX/abcdefghijklmnopqrstuvwx', 'Wanderer', '2023-01-02 13:00:00', '2023-01-01 12:00:00'),
('user-003', 'mjones@example.com', '$2b$10$ABCDEFGHIJKLMNOPQRSTUVWX/abcdefghijklmnopqrstuvwx', 'Wanderer', '2023-01-03 14:00:00', '2023-01-01 12:00:00');