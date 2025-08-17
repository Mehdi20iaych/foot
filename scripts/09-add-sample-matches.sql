-- Insert sample matches for today to test the prediction functionality
INSERT INTO matches (
  home_team,
  away_team,
  league,
  match_date,
  prediction_deadline,
  status
) VALUES 
(
  'Manchester United',
  'Liverpool',
  'Premier League',
  CURRENT_DATE + INTERVAL '6 hours',
  CURRENT_DATE + INTERVAL '5 hours 30 minutes',
  'scheduled'
),
(
  'Barcelona',
  'Real Madrid',
  'La Liga',
  CURRENT_DATE + INTERVAL '8 hours',
  CURRENT_DATE + INTERVAL '7 hours 30 minutes',
  'scheduled'
),
(
  'Bayern Munich',
  'Borussia Dortmund',
  'Bundesliga',
  CURRENT_DATE + INTERVAL '10 hours',
  CURRENT_DATE + INTERVAL '9 hours 30 minutes',
  'scheduled'
);
