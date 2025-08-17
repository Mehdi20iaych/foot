-- Performance indexes for common queries

-- Users table indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_total_points ON users(total_points DESC);
CREATE INDEX IF NOT EXISTS idx_users_current_streak ON users(current_streak DESC);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);

-- Matches table indexes
CREATE INDEX IF NOT EXISTS idx_matches_date ON matches(match_date);
CREATE INDEX IF NOT EXISTS idx_matches_status ON matches(status);
CREATE INDEX IF NOT EXISTS idx_matches_league ON matches(league);
CREATE INDEX IF NOT EXISTS idx_matches_prediction_deadline ON matches(prediction_deadline);
CREATE INDEX IF NOT EXISTS idx_matches_featured ON matches(is_featured) WHERE is_featured = true;

-- Predictions table indexes
CREATE INDEX IF NOT EXISTS idx_predictions_user_id ON predictions(user_id);
CREATE INDEX IF NOT EXISTS idx_predictions_match_id ON predictions(match_id);
CREATE INDEX IF NOT EXISTS idx_predictions_created_at ON predictions(created_at);
CREATE INDEX IF NOT EXISTS idx_predictions_points ON predictions(points_earned DESC);
CREATE INDEX IF NOT EXISTS idx_predictions_user_match ON predictions(user_id, match_id);

-- Daily contests indexes
CREATE INDEX IF NOT EXISTS idx_daily_contests_date ON daily_contests(contest_date DESC);
CREATE INDEX IF NOT EXISTS idx_daily_contests_active ON daily_contests(is_active) WHERE is_active = true;

-- User contest participation indexes
CREATE INDEX IF NOT EXISTS idx_user_contest_participation_user ON user_contest_participation(user_id);
CREATE INDEX IF NOT EXISTS idx_user_contest_participation_contest ON user_contest_participation(contest_id);
CREATE INDEX IF NOT EXISTS idx_user_contest_participation_rank ON user_contest_participation(daily_rank);

-- Posts table indexes
CREATE INDEX IF NOT EXISTS idx_posts_user_id ON posts(user_id);
CREATE INDEX IF NOT EXISTS idx_posts_created_at ON posts(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_type ON posts(post_type);
CREATE INDEX IF NOT EXISTS idx_posts_match_id ON posts(match_id) WHERE match_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_posts_likes ON posts(likes_count DESC);

-- Comments table indexes
CREATE INDEX IF NOT EXISTS idx_comments_post_id ON comments(post_id);
CREATE INDEX IF NOT EXISTS idx_comments_user_id ON comments(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_parent ON comments(parent_comment_id) WHERE parent_comment_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_comments_created_at ON comments(created_at);

-- Likes table indexes
CREATE INDEX IF NOT EXISTS idx_likes_user_id ON likes(user_id);
CREATE INDEX IF NOT EXISTS idx_likes_post_id ON likes(post_id) WHERE post_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_likes_comment_id ON likes(comment_id) WHERE comment_id IS NOT NULL;

-- Follows table indexes
CREATE INDEX IF NOT EXISTS idx_follows_follower ON follows(follower_id);
CREATE INDEX IF NOT EXISTS idx_follows_following ON follows(following_id);

-- Achievements indexes
CREATE INDEX IF NOT EXISTS idx_achievements_category ON achievements(category);
CREATE INDEX IF NOT EXISTS idx_achievements_active ON achievements(is_active) WHERE is_active = true;
CREATE INDEX IF NOT EXISTS idx_user_achievements_user ON user_achievements(user_id);
CREATE INDEX IF NOT EXISTS idx_user_achievements_earned_at ON user_achievements(earned_at DESC);

-- Notifications indexes
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_unread ON notifications(user_id, is_read) WHERE is_read = false;
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON notifications(created_at DESC);
