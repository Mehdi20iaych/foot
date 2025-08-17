-- Create automatic UCL and Premier League match generation
-- Drop existing matches and create new structure for automatic matches
TRUNCATE TABLE matches CASCADE;

-- Create function to generate UCL and Premier League matches
CREATE OR REPLACE FUNCTION generate_weekly_matches()
RETURNS void AS $$
DECLARE
    match_date DATE;
    match_time TIME;
BEGIN
    -- Clear existing future matches
    DELETE FROM matches WHERE match_date >= CURRENT_DATE;
    
    -- Generate UCL matches (Tuesdays and Wednesdays)
    FOR i IN 0..6 LOOP
        match_date := CURRENT_DATE + (i * 7) + 1; -- Next Tuesday
        match_time := '20:00:00';
        
        -- Tuesday UCL matches
        INSERT INTO matches (home_team, away_team, competition, match_date, match_time, prediction_deadline)
        VALUES 
            ('Real Madrid', 'Manchester City', 'UEFA Champions League', match_date, match_time, match_date + match_time - INTERVAL '1 hour'),
            ('Barcelona', 'PSG', 'UEFA Champions League', match_date, match_time + INTERVAL '2 hours', match_date + match_time + INTERVAL '1 hour'),
            ('Bayern Munich', 'Arsenal', 'UEFA Champions League', match_date, match_time + INTERVAL '4 hours', match_date + match_time + INTERVAL '3 hours');
        
        -- Wednesday UCL matches
        match_date := match_date + 1; -- Wednesday
        INSERT INTO matches (home_team, away_team, competition, match_date, match_time, prediction_deadline)
        VALUES 
            ('Liverpool', 'AC Milan', 'UEFA Champions League', match_date, match_time, match_date + match_time - INTERVAL '1 hour'),
            ('Juventus', 'Chelsea', 'UEFA Champions League', match_date, match_time + INTERVAL '2 hours', match_date + match_time + INTERVAL '1 hour'),
            ('Atletico Madrid', 'Borussia Dortmund', 'UEFA Champions League', match_date, match_time + INTERVAL '4 hours', match_date + match_time + INTERVAL '3 hours');
    END LOOP;
    
    -- Generate Premier League matches (Saturdays and Sundays)
    FOR i IN 0..6 LOOP
        match_date := CURRENT_DATE + (i * 7) + 5; -- Next Saturday
        match_time := '15:00:00';
        
        -- Saturday Premier League matches
        INSERT INTO matches (home_team, away_team, competition, match_date, match_time, prediction_deadline)
        VALUES 
            ('Manchester United', 'Liverpool', 'Premier League', match_date, match_time, match_date + match_time - INTERVAL '1 hour'),
            ('Arsenal', 'Chelsea', 'Premier League', match_date, match_time + INTERVAL '2.5 hours', match_date + match_time + INTERVAL '1.5 hours'),
            ('Manchester City', 'Tottenham', 'Premier League', match_date, match_time + INTERVAL '5 hours', match_date + match_time + INTERVAL '4 hours');
        
        -- Sunday Premier League matches
        match_date := match_date + 1; -- Sunday
        INSERT INTO matches (home_team, away_team, competition, match_date, match_time, prediction_deadline)
        VALUES 
            ('Newcastle', 'Brighton', 'Premier League', match_date, match_time, match_date + match_time - INTERVAL '1 hour'),
            ('West Ham', 'Everton', 'Premier League', match_date, match_time + INTERVAL '2 hours', match_date + match_time + INTERVAL '1 hour'),
            ('Aston Villa', 'Crystal Palace', 'Premier League', match_date, match_time + INTERVAL '4 hours', match_date + match_time + INTERVAL '3 hours');
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Generate initial matches
SELECT generate_weekly_matches();

-- Create a scheduled function to run weekly (this would typically be handled by a cron job)
-- For now, we'll create a function that can be called to refresh matches
CREATE OR REPLACE FUNCTION refresh_matches()
RETURNS void AS $$
BEGIN
    PERFORM generate_weekly_matches();
END;
$$ LANGUAGE plpgsql;
