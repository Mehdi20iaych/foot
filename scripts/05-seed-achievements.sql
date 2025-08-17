-- Seed initial achievements for the prediction contest

INSERT INTO achievements (name, description, icon, category, criteria, points_reward, badge_color, rarity, sort_order) VALUES
-- Streak achievements
('First Steps', 'Make your first prediction', 'target', 'milestone', '{"predictions_made": 1}', 10, 'green', 'common', 1),
('Hot Streak', 'Get 3 predictions correct in a row', 'flame', 'streak', '{"streak": 3}', 50, 'orange', 'common', 2),
('On Fire', 'Get 5 predictions correct in a row', 'fire', 'streak', '{"streak": 5}', 100, 'red', 'rare', 3),
('Unstoppable', 'Get 10 predictions correct in a row', 'zap', 'streak', '{"streak": 10}', 250, 'purple', 'epic', 4),
('Legend', 'Get 20 predictions correct in a row', 'crown', 'streak', '{"streak": 20}', 500, 'gold', 'legendary', 5),

-- Accuracy achievements
('Sharp Shooter', 'Achieve 70% accuracy with at least 10 predictions', 'crosshair', 'accuracy', '{"accuracy": 70, "min_predictions": 10}', 75, 'blue', 'common', 6),
('Sniper', 'Achieve 80% accuracy with at least 25 predictions', 'scope', 'accuracy', '{"accuracy": 80, "min_predictions": 25}', 150, 'indigo', 'rare', 7),
('Oracle', 'Achieve 90% accuracy with at least 50 predictions', 'eye', 'accuracy', '{"accuracy": 90, "min_predictions": 50}', 300, 'purple', 'epic', 8),

-- Social achievements
('Social Butterfly', 'Make 10 posts in the community feed', 'message-circle', 'social', '{"posts_made": 10}', 25, 'pink', 'common', 9),
('Popular', 'Receive 50 likes on your posts', 'heart', 'social', '{"likes_received": 50}', 50, 'red', 'common', 10),
('Influencer', 'Get 10 followers', 'users', 'social', '{"followers": 10}', 100, 'blue', 'rare', 11),

-- Milestone achievements
('Century', 'Make 100 predictions', 'hundred-points', 'milestone', '{"predictions_made": 100}', 100, 'green', 'rare', 12),
('Dedicated', 'Participate for 30 consecutive days', 'calendar', 'milestone', '{"consecutive_days": 30}', 200, 'blue', 'rare', 13),
('Point Master', 'Earn 1000 total points', 'trophy', 'milestone', '{"total_points": 1000}', 150, 'gold', 'rare', 14),

-- Special achievements
('Perfect Day', 'Get all 3 daily predictions correct', 'star', 'accuracy', '{"perfect_daily_contest": 1}', 75, 'yellow', 'rare', 15),
('Hat Trick', 'Get 3 perfect days in a week', 'hat', 'accuracy', '{"perfect_days_in_week": 3}', 200, 'purple', 'epic', 16),
('Early Bird', 'Make predictions within 1 hour of matches being available', 'sunrise', 'milestone', '{"early_predictions": 10}', 50, 'orange', 'common', 17);
