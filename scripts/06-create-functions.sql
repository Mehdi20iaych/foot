-- Create function to increment user predictions count
CREATE OR REPLACE FUNCTION increment_user_predictions(user_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE users 
  SET total_predictions = total_predictions + 1,
      updated_at = NOW()
  WHERE id = user_id;
END;
$$ LANGUAGE plpgsql;

-- Create function to calculate and update user accuracy
CREATE OR REPLACE FUNCTION update_user_accuracy(user_id UUID)
RETURNS void AS $$
DECLARE
  total_preds INTEGER;
  correct_preds INTEGER;
  new_accuracy DECIMAL(5,2);
BEGIN
  -- Get total predictions for user
  SELECT COUNT(*) INTO total_preds
  FROM predictions 
  WHERE user_id = user_id AND is_correct IS NOT NULL;
  
  -- Get correct predictions for user
  SELECT COUNT(*) INTO correct_preds
  FROM predictions 
  WHERE user_id = user_id AND is_correct = true;
  
  -- Calculate accuracy
  IF total_preds > 0 THEN
    new_accuracy := (correct_preds::DECIMAL / total_preds::DECIMAL) * 100;
  ELSE
    new_accuracy := 0;
  END IF;
  
  -- Update user record
  UPDATE users 
  SET correct_predictions = correct_preds,
      prediction_accuracy = new_accuracy,
      updated_at = NOW()
  WHERE id = user_id;
END;
$$ LANGUAGE plpgsql;

-- Create function to update user streak
CREATE OR REPLACE FUNCTION update_user_streak(user_id UUID)
RETURNS void AS $$
DECLARE
  current_streak_count INTEGER := 0;
  longest_streak_count INTEGER;
  pred RECORD;
BEGIN
  -- Get current longest streak
  SELECT longest_streak INTO longest_streak_count
  FROM users WHERE id = user_id;
  
  -- Calculate current streak by looking at recent predictions in reverse chronological order
  FOR pred IN 
    SELECT is_correct 
    FROM predictions p
    JOIN matches m ON p.match_id = m.id
    WHERE p.user_id = user_id 
      AND p.is_correct IS NOT NULL
      AND m.status = 'finished'
    ORDER BY m.match_date DESC
  LOOP
    IF pred.is_correct THEN
      current_streak_count := current_streak_count + 1;
    ELSE
      EXIT; -- Break the streak
    END IF;
  END LOOP;
  
  -- Update longest streak if current is longer
  IF current_streak_count > longest_streak_count THEN
    longest_streak_count := current_streak_count;
  END IF;
  
  -- Update user record
  UPDATE users 
  SET current_streak = current_streak_count,
      longest_streak = longest_streak_count,
      updated_at = NOW()
  WHERE id = user_id;
END;
$$ LANGUAGE plpgsql;
