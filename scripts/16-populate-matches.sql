-- Create UCL and Premier League matches for the next few weeks
INSERT INTO matches (
  id,
  home_team,
  away_team,
  home_logo,
  away_logo,
  match_date,
  prediction_deadline,
  league,
  status
) VALUES
-- UCL Matches - Week 1 (Tuesday)
(gen_random_uuid(), 'Manchester City', 'Real Madrid', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day' + TIME '20:00', CURRENT_DATE + INTERVAL '1 day' + TIME '19:45', 'Champions League', 'upcoming'),
(gen_random_uuid(), 'Barcelona', 'Bayern Munich', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day' + TIME '20:00', CURRENT_DATE + INTERVAL '1 day' + TIME '19:45', 'Champions League', 'upcoming'),

-- UCL Matches - Week 1 (Wednesday)
(gen_random_uuid(), 'Liverpool', 'PSG', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days' + TIME '20:00', CURRENT_DATE + INTERVAL '2 days' + TIME '19:45', 'Champions League', 'upcoming'),
(gen_random_uuid(), 'Arsenal', 'AC Milan', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days' + TIME '20:00', CURRENT_DATE + INTERVAL '2 days' + TIME '19:45', 'Champions League', 'upcoming'),

-- Premier League Matches - This Weekend (Saturday)
(gen_random_uuid(), 'Manchester United', 'Chelsea', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 days' + TIME '17:30', CURRENT_DATE + INTERVAL '3 days' + TIME '17:15', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Tottenham', 'Newcastle', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 days' + TIME '15:00', CURRENT_DATE + INTERVAL '3 days' + TIME '14:45', 'Premier League', 'upcoming'),

-- Premier League Matches - This Weekend (Sunday)
(gen_random_uuid(), 'Liverpool', 'Manchester City', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '4 days' + TIME '16:30', CURRENT_DATE + INTERVAL '4 days' + TIME '16:15', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Arsenal', 'Aston Villa', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '4 days' + TIME '14:00', CURRENT_DATE + INTERVAL '4 days' + TIME '13:45', 'Premier League', 'upcoming'),

-- Today's Matches (for immediate testing)
(gen_random_uuid(), 'Brighton', 'West Ham', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + TIME '20:00', CURRENT_DATE + TIME '19:45', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Everton', 'Fulham', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + TIME '17:30', CURRENT_DATE + TIME '17:15', 'Premier League', 'upcoming'),

-- UCL Matches - Week 2 (Next Tuesday)
(gen_random_uuid(), 'Juventus', 'Atletico Madrid', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '8 days' + TIME '20:00', CURRENT_DATE + INTERVAL '8 days' + TIME '19:45', 'Champions League', 'upcoming'),
(gen_random_uuid(), 'Inter Milan', 'Borussia Dortmund', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '8 days' + TIME '20:00', CURRENT_DATE + INTERVAL '8 days' + TIME '19:45', 'Champions League', 'upcoming');
