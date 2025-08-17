-- Create users table with extended profile for prediction contest
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  username TEXT UNIQUE,
  display_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Prediction contest specific fields
  current_streak INTEGER DEFAULT 0,
  longest_streak INTEGER DEFAULT 0,
  total_points INTEGER DEFAULT 0,
  total_predictions INTEGER DEFAULT 0,
  correct_predictions INTEGER DEFAULT 0,
  prediction_accuracy DECIMAL(5,2) DEFAULT 0.00,
  
  -- User preferences
  favorite_team TEXT,
  notification_preferences JSONB DEFAULT '{"email": true, "push": false}',
  is_active BOOLEAN DEFAULT true,
  is_admin BOOLEAN DEFAULT false
);

-- Create matches table for daily football matches
CREATE TABLE IF NOT EXISTS matches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  external_match_id TEXT UNIQUE, -- For API integration
  home_team TEXT NOT NULL,
  away_team TEXT NOT NULL,
  home_team_logo TEXT,
  away_team_logo TEXT,
  league TEXT NOT NULL,
  match_date TIMESTAMP WITH TIME ZONE NOT NULL,
  
  -- Match status and results
  status TEXT DEFAULT 'scheduled', -- scheduled, live, finished, cancelled
  home_score INTEGER,
  away_score INTEGER,
  
  -- Prediction window
  prediction_deadline TIMESTAMP WITH TIME ZONE NOT NULL,
  is_featured BOOLEAN DEFAULT false, -- For highlighting important matches
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create predictions table
CREATE TABLE IF NOT EXISTS predictions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  match_id UUID NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
  
  -- Prediction details
  predicted_home_score INTEGER NOT NULL,
  predicted_away_score INTEGER NOT NULL,
  predicted_result TEXT NOT NULL, -- 'home_win', 'away_win', 'draw'
  confidence_level INTEGER DEFAULT 3, -- 1-5 scale
  
  -- Scoring and results
  points_earned INTEGER DEFAULT 0,
  is_correct BOOLEAN,
  exact_score_match BOOLEAN DEFAULT false,
  result_match BOOLEAN DEFAULT false,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Ensure one prediction per user per match
  UNIQUE(user_id, match_id)
);

-- Create daily_contests table for organizing daily prediction sets
CREATE TABLE IF NOT EXISTS daily_contests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contest_date DATE NOT NULL UNIQUE,
  featured_matches UUID[] NOT NULL, -- Array of match IDs (3 matches per day)
  total_participants INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  prize_pool INTEGER DEFAULT 0, -- For future monetization
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create user_contest_participation table
CREATE TABLE IF NOT EXISTS user_contest_participation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  contest_id UUID NOT NULL REFERENCES daily_contests(id) ON DELETE CASCADE,
  
  predictions_made INTEGER DEFAULT 0,
  total_points INTEGER DEFAULT 0,
  daily_rank INTEGER,
  completed_all_predictions BOOLEAN DEFAULT false,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  UNIQUE(user_id, contest_id)
);
