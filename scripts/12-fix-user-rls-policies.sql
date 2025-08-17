-- Fix RLS policies for users table to allow registration and proper access

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can insert own profile" ON users;
DROP POLICY IF EXISTS "Users can view own profile" ON users;
DROP POLICY IF EXISTS "Users can update own profile" ON users;
DROP POLICY IF EXISTS "Public profiles are viewable by everyone" ON users;

-- Enable RLS on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy 1: Allow users to insert their own profile during registration
-- This is crucial for signup to work
CREATE POLICY "Users can insert own profile" ON users
  FOR INSERT 
  WITH CHECK (auth.uid() = id);

-- Policy 2: Allow users to view their own profile
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT 
  USING (auth.uid() = id);

-- Policy 3: Allow users to update their own profile
CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE 
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Policy 4: Allow public read access to basic profile info for leaderboards
-- This allows other users to see usernames, points, streaks for leaderboards
CREATE POLICY "Public profiles are viewable by everyone" ON users
  FOR SELECT 
  USING (true);

-- Also ensure predictions table has proper RLS policies
ALTER TABLE predictions ENABLE ROW LEVEL SECURITY;

-- Drop existing prediction policies if they exist
DROP POLICY IF EXISTS "Users can insert own predictions" ON predictions;
DROP POLICY IF EXISTS "Users can view own predictions" ON predictions;
DROP POLICY IF EXISTS "Public predictions are viewable" ON predictions;

-- Allow users to insert their own predictions
CREATE POLICY "Users can insert own predictions" ON predictions
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- Allow users to view their own predictions
CREATE POLICY "Users can view own predictions" ON predictions
  FOR SELECT 
  USING (auth.uid() = user_id);

-- Allow public read access to all predictions for leaderboards and social features
CREATE POLICY "Public predictions are viewable" ON predictions
  FOR SELECT 
  USING (true);

-- Ensure matches table allows public read access
ALTER TABLE matches ENABLE ROW LEVEL SECURITY;

-- Drop existing match policies if they exist
DROP POLICY IF EXISTS "Matches are publicly viewable" ON matches;
DROP POLICY IF EXISTS "Only admins can manage matches" ON matches;

-- Allow everyone to view matches
CREATE POLICY "Matches are publicly viewable" ON matches
  FOR SELECT 
  USING (true);

-- Only allow admins to insert/update/delete matches
CREATE POLICY "Only admins can manage matches" ON matches
  FOR ALL 
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.is_admin = true
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.is_admin = true
    )
  );
