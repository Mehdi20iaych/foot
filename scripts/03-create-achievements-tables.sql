-- Create achievements table for gamification
CREATE TABLE IF NOT EXISTS achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  icon TEXT, -- Icon identifier or URL
  category TEXT NOT NULL, -- 'streak', 'accuracy', 'social', 'milestone'
  
  -- Achievement criteria
  criteria JSONB NOT NULL, -- Flexible criteria storage
  points_reward INTEGER DEFAULT 0,
  badge_color TEXT DEFAULT 'blue',
  
  -- Rarity and ordering
  rarity TEXT DEFAULT 'common', -- 'common', 'rare', 'epic', 'legendary'
  sort_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create user_achievements table
CREATE TABLE IF NOT EXISTS user_achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  achievement_id UUID NOT NULL REFERENCES achievements(id) ON DELETE CASCADE,
  
  earned_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  progress_data JSONB, -- For tracking progress towards achievement
  
  UNIQUE(user_id, achievement_id)
);

-- Create leaderboards table for different ranking types
CREATE TABLE IF NOT EXISTS leaderboards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  leaderboard_type TEXT NOT NULL, -- 'daily', 'weekly', 'monthly', 'all_time', 'streak'
  period_start DATE,
  period_end DATE,
  
  -- Leaderboard data (stored as JSONB for flexibility)
  rankings JSONB NOT NULL, -- Array of user rankings with scores
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Ensure unique leaderboards per type and period
  UNIQUE(leaderboard_type, period_start, period_end)
);

-- Create notifications table
CREATE TABLE IF NOT EXISTS notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  
  notification_type TEXT NOT NULL, -- 'achievement', 'match_result', 'social', 'contest'
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  
  -- Related entities
  related_user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  related_match_id UUID REFERENCES matches(id) ON DELETE SET NULL,
  related_post_id UUID REFERENCES posts(id) ON DELETE SET NULL,
  
  -- Notification state
  is_read BOOLEAN DEFAULT false,
  is_pushed BOOLEAN DEFAULT false,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
