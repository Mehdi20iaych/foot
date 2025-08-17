-- Create function to increment user predictions count
CREATE OR REPLACE FUNCTION increment_user_predictions(user_id UUID)
RETURNS void AS $$
BEGIN
  INSERT INTO users (id, total_predictions)
  VALUES (user_id, 1)
  ON CONFLICT (id)
  DO UPDATE SET 
    total_predictions = COALESCE(users.total_predictions, 0) + 1,
    updated_at = NOW();
END;
$$ LANGUAGE plpgsql;
