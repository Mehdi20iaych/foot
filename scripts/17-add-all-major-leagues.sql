-- Add matches from all major football leagues worldwide
-- This includes Premier League, La Liga, Serie A, Bundesliga, Ligue 1, Champions League, Europa League, and more

-- Clear existing matches first
DELETE FROM matches;

-- Premier League (England) - Saturdays and Sundays
INSERT INTO matches (id, home_team, away_team, home_logo, away_logo, match_date, prediction_deadline, league, status) VALUES
(gen_random_uuid(), 'Manchester City', 'Arsenal', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 hours', CURRENT_DATE + INTERVAL '1 hour 45 minutes', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Liverpool', 'Chelsea', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '5 hours', CURRENT_DATE + INTERVAL '4 hour 45 minutes', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Manchester United', 'Tottenham', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day 3 hours', CURRENT_DATE + INTERVAL '1 day 2 hour 45 minutes', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Newcastle', 'Brighton', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day 6 hours', CURRENT_DATE + INTERVAL '1 day 5 hour 45 minutes', 'Premier League', 'upcoming'),
(gen_random_uuid(), 'Aston Villa', 'West Ham', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days 3 hours', CURRENT_DATE + INTERVAL '2 days 2 hour 45 minutes', 'Premier League', 'upcoming'),

-- La Liga (Spain) - Saturdays and Sundays
(gen_random_uuid(), 'Real Madrid', 'Barcelona', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 hours', CURRENT_DATE + INTERVAL '2 hour 45 minutes', 'La Liga', 'upcoming'),
(gen_random_uuid(), 'Atletico Madrid', 'Sevilla', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day 4 hours', CURRENT_DATE + INTERVAL '1 day 3 hour 45 minutes', 'La Liga', 'upcoming'),
(gen_random_uuid(), 'Valencia', 'Real Sociedad', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days 4 hours', CURRENT_DATE + INTERVAL '2 days 3 hour 45 minutes', 'La Liga', 'upcoming'),
(gen_random_uuid(), 'Villarreal', 'Athletic Bilbao', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 days 3 hours', CURRENT_DATE + INTERVAL '3 days 2 hour 45 minutes', 'La Liga', 'upcoming'),

-- Serie A (Italy) - Saturdays and Sundays
(gen_random_uuid(), 'Juventus', 'Inter Milan', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '4 hours', CURRENT_DATE + INTERVAL '3 hour 45 minutes', 'Serie A', 'upcoming'),
(gen_random_uuid(), 'AC Milan', 'Napoli', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day 5 hours', CURRENT_DATE + INTERVAL '1 day 4 hour 45 minutes', 'Serie A', 'upcoming'),
(gen_random_uuid(), 'Roma', 'Lazio', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days 5 hours', CURRENT_DATE + INTERVAL '2 days 4 hour 45 minutes', 'Serie A', 'upcoming'),
(gen_random_uuid(), 'Atalanta', 'Fiorentina', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 days 4 hours', CURRENT_DATE + INTERVAL '3 days 3 hour 45 minutes', 'Serie A', 'upcoming'),

-- Bundesliga (Germany) - Saturdays and Sundays
(gen_random_uuid(), 'Bayern Munich', 'Borussia Dortmund', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 hour', CURRENT_DATE + INTERVAL '45 minutes', 'Bundesliga', 'upcoming'),
(gen_random_uuid(), 'RB Leipzig', 'Bayer Leverkusen', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day 2 hours', CURRENT_DATE + INTERVAL '1 day 1 hour 45 minutes', 'Bundesliga', 'upcoming'),
(gen_random_uuid(), 'Borussia Monchengladbach', 'Eintracht Frankfurt', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days 2 hours', CURRENT_DATE + INTERVAL '2 days 1 hour 45 minutes', 'Bundesliga', 'upcoming'),
(gen_random_uuid(), 'VfB Stuttgart', 'Wolfsburg', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 days 2 hours', CURRENT_DATE + INTERVAL '3 days 1 hour 45 minutes', 'Bundesliga', 'upcoming'),

-- Ligue 1 (France) - Saturdays and Sundays
(gen_random_uuid(), 'PSG', 'Marseille', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '6 hours', CURRENT_DATE + INTERVAL '5 hour 45 minutes', 'Ligue 1', 'upcoming'),
(gen_random_uuid(), 'Lyon', 'Monaco', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '1 day 7 hours', CURRENT_DATE + INTERVAL '1 day 6 hour 45 minutes', 'Ligue 1', 'upcoming'),
(gen_random_uuid(), 'Nice', 'Lille', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '2 days 6 hours', CURRENT_DATE + INTERVAL '2 days 5 hour 45 minutes', 'Ligue 1', 'upcoming'),
(gen_random_uuid(), 'Rennes', 'Strasbourg', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '3 days 5 hours', CURRENT_DATE + INTERVAL '3 days 4 hour 45 minutes', 'Ligue 1', 'upcoming'),

-- Champions League (UCL) - Tuesdays and Wednesdays
(gen_random_uuid(), 'Real Madrid', 'Manchester City', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '4 days 20 hours', CURRENT_DATE + INTERVAL '4 days 19 hour 45 minutes', 'Champions League', 'upcoming'),
(gen_random_uuid(), 'Barcelona', 'PSG', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '4 days 22 hours', CURRENT_DATE + INTERVAL '4 days 21 hour 45 minutes', 'Champions League', 'upcoming'),
(gen_random_uuid(), 'Bayern Munich', 'Arsenal', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '5 days 20 hours', CURRENT_DATE + INTERVAL '5 days 19 hour 45 minutes', 'Champions League', 'upcoming'),
(gen_random_uuid(), 'Liverpool', 'Inter Milan', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '5 days 22 hours', CURRENT_DATE + INTERVAL '5 days 21 hour 45 minutes', 'Champions League', 'upcoming'),

-- Europa League - Thursdays
(gen_random_uuid(), 'Atletico Madrid', 'Bayer Leverkusen', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '6 days 20 hours', CURRENT_DATE + INTERVAL '6 days 19 hour 45 minutes', 'Europa League', 'upcoming'),
(gen_random_uuid(), 'Roma', 'Brighton', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '6 days 22 hours', CURRENT_DATE + INTERVAL '6 days 21 hour 45 minutes', 'Europa League', 'upcoming'),

-- Eredivisie (Netherlands)
(gen_random_uuid(), 'Ajax', 'PSV', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '7 days 3 hours', CURRENT_DATE + INTERVAL '7 days 2 hour 45 minutes', 'Eredivisie', 'upcoming'),
(gen_random_uuid(), 'Feyenoord', 'AZ Alkmaar', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '8 days 3 hours', CURRENT_DATE + INTERVAL '8 days 2 hour 45 minutes', 'Eredivisie', 'upcoming'),

-- Primeira Liga (Portugal)
(gen_random_uuid(), 'Benfica', 'Porto', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '7 days 4 hours', CURRENT_DATE + INTERVAL '7 days 3 hour 45 minutes', 'Primeira Liga', 'upcoming'),
(gen_random_uuid(), 'Sporting CP', 'Braga', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '8 days 4 hours', CURRENT_DATE + INTERVAL '8 days 3 hour 45 minutes', 'Primeira Liga', 'upcoming'),

-- MLS (Major League Soccer)
(gen_random_uuid(), 'LA Galaxy', 'LAFC', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '9 days 2 hours', CURRENT_DATE + INTERVAL '9 days 1 hour 45 minutes', 'MLS', 'upcoming'),
(gen_random_uuid(), 'Inter Miami', 'Atlanta United', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '9 days 5 hours', CURRENT_DATE + INTERVAL '9 days 4 hour 45 minutes', 'MLS', 'upcoming'),

-- Brazilian Serie A
(gen_random_uuid(), 'Flamengo', 'Palmeiras', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '10 days 2 hours', CURRENT_DATE + INTERVAL '10 days 1 hour 45 minutes', 'Serie A (Brazil)', 'upcoming'),
(gen_random_uuid(), 'Corinthians', 'Santos', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '10 days 5 hours', CURRENT_DATE + INTERVAL '10 days 4 hour 45 minutes', 'Serie A (Brazil)', 'upcoming'),

-- Argentine Primera División
(gen_random_uuid(), 'Boca Juniors', 'River Plate', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '11 days 2 hours', CURRENT_DATE + INTERVAL '11 days 1 hour 45 minutes', 'Primera División (Argentina)', 'upcoming'),
(gen_random_uuid(), 'Racing Club', 'Independiente', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE + INTERVAL '11 days 5 hours', CURRENT_DATE + INTERVAL '11 days 4 hour 45 minutes', 'Primera División (Argentina)', 'upcoming');

-- Add some completed matches for demonstration
INSERT INTO matches (id, home_team, away_team, home_logo, away_logo, match_date, prediction_deadline, league, status, home_score, away_score) VALUES
(gen_random_uuid(), 'Manchester City', 'Liverpool', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE - INTERVAL '1 day 15 minutes', 'Premier League', 'completed', 2, 1),
(gen_random_uuid(), 'Real Madrid', 'Barcelona', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE - INTERVAL '2 days 15 minutes', 'La Liga', 'completed', 3, 1),
(gen_random_uuid(), 'Bayern Munich', 'Borussia Dortmund', '/placeholder.svg?height=40&width=40', '/placeholder.svg?height=40&width=40', CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE - INTERVAL '3 days 15 minutes', 'Bundesliga', 'completed', 1, 0);
