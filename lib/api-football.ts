const API_KEY = "026125d61f7059b8e13ca4509cd0de88"
const BASE_URL = "https://v3.football.api-sports.io"

import { createClient } from "@/lib/supabase/server"
import { v4 as uuidv4 } from "uuid"

interface ApiFootballMatch {
  fixture: {
    id: number
    date: string
    status: {
      short: string
    }
  }
  league: {
    id: number
    name: string
    country: string
    logo: string
  }
  teams: {
    home: {
      id: number
      name: string
      logo: string
    }
    away: {
      id: number
      name: string
      logo: string
    }
  }
  goals: {
    home: number | null
    away: number | null
  }
}

// Major league IDs from API-Football
const MAJOR_LEAGUES = {
  PREMIER_LEAGUE: 39,
  LA_LIGA: 140,
  SERIE_A: 135,
  BUNDESLIGA: 78,
  LIGUE_1: 61,
  CHAMPIONS_LEAGUE: 2,
  EUROPA_LEAGUE: 3,
  EREDIVISIE: 88,
  PRIMEIRA_LIGA: 94,
  MLS: 253,
  BRASILEIRAO: 71,
  ARGENTINA_PRIMERA: 128,
}

async function fetchFromAPI(endpoint: string) {
  const response = await fetch(`${BASE_URL}${endpoint}`, {
    headers: {
      "X-RapidAPI-Key": API_KEY,
      "X-RapidAPI-Host": "v3.football.api-sports.io",
    },
  })

  if (!response.ok) {
    throw new Error(`API request failed: ${response.statusText}`)
  }

  return response.json()
}

export async function getTodaysMatches() {
  try {
    const today = new Date().toISOString().split("T")[0]
    const data = await fetchFromAPI(`/fixtures?date=${today}`)

    // Filter for major leagues only
    const majorLeagueIds = Object.values(MAJOR_LEAGUES)
    const filteredMatches = data.response.filter((match: ApiFootballMatch) => majorLeagueIds.includes(match.league.id))

    const transformedMatches = filteredMatches.map(transformMatch)

    await syncMatchesToDatabase(transformedMatches)

    return transformedMatches
  } catch (error) {
    console.error("Error fetching today's matches:", error)
    return await getMatchesFromDatabase()
  }
}

export async function getUpcomingMatches(days = 7) {
  try {
    const today = new Date()
    const endDate = new Date(today.getTime() + days * 24 * 60 * 60 * 1000)

    const data = await fetchFromAPI(
      `/fixtures?from=${today.toISOString().split("T")[0]}&to=${endDate.toISOString().split("T")[0]}`,
    )

    // Filter for major leagues only
    const majorLeagueIds = Object.values(MAJOR_LEAGUES)
    const filteredMatches = data.response.filter((match: ApiFootballMatch) => majorLeagueIds.includes(match.league.id))

    return filteredMatches.map(transformMatch)
  } catch (error) {
    console.error("Error fetching upcoming matches:", error)
    return []
  }
}

export async function getLeagueMatches(leagueId: number, season: number = new Date().getFullYear()) {
  try {
    const data = await fetchFromAPI(`/fixtures?league=${leagueId}&season=${season}`)
    return data.response.map(transformMatch)
  } catch (error) {
    console.error(`Error fetching matches for league ${leagueId}:`, error)
    return []
  }
}

function transformMatch(apiMatch: ApiFootballMatch) {
  const matchDate = new Date(apiMatch.fixture.date)
  const predictionDeadline = new Date(matchDate.getTime() - 15 * 60 * 1000) // 15 minutes before

  return {
    id: uuidv4(), // Generate UUID for database ID
    external_match_id: apiMatch.fixture.id.toString(),
    home_team: apiMatch.teams.home.name,
    away_team: apiMatch.teams.away.name,
    home_team_logo: apiMatch.teams.home.logo,
    away_team_logo: apiMatch.teams.away.logo,
    match_date: apiMatch.fixture.date,
    prediction_deadline: predictionDeadline.toISOString(),
    league: apiMatch.league.name,
    league_logo: apiMatch.league.logo,
    country: apiMatch.league.country,
    status: apiMatch.fixture.status.short,
    home_score: apiMatch.goals.home,
    away_score: apiMatch.goals.away,
    is_finished: ["FT", "AET", "PEN"].includes(apiMatch.fixture.status.short),
  }
}

async function syncMatchesToDatabase(matches: any[]) {
  try {
    const supabase = createClient()

    for (const match of matches) {
      const { data: existingMatch } = await supabase
        .from("matches")
        .select("id")
        .eq("external_match_id", match.external_match_id)
        .single()

      const matchData = {
        external_match_id: match.external_match_id,
        home_team: match.home_team,
        away_team: match.away_team,
        home_team_logo: match.home_team_logo,
        away_team_logo: match.away_team_logo,
        match_date: match.match_date,
        prediction_deadline: match.prediction_deadline,
        league: match.league,
        status: match.status,
        home_score: match.home_score,
        away_score: match.away_score,
        is_featured: true,
        updated_at: new Date().toISOString(),
      }

      if (existingMatch) {
        // Update existing match
        await supabase.from("matches").update(matchData).eq("id", existingMatch.id)
      } else {
        // Insert new match (UUID will be auto-generated)
        await supabase.from("matches").insert({ id: match.id, ...matchData })
      }
    }
  } catch (error) {
    console.error("Error syncing matches to database:", error)
  }
}

async function getMatchesFromDatabase() {
  try {
    const supabase = createClient()
    const today = new Date().toISOString().split("T")[0]

    const { data: matches } = await supabase
      .from("matches")
      .select("*")
      .gte("match_date", today)
      .lt("match_date", `${today}T23:59:59`)
      .order("match_date", { ascending: true })

    return (
      matches?.map((match) => ({
        id: match.id, // Use database UUID
        external_match_id: match.external_match_id,
        home_team: match.home_team,
        away_team: match.away_team,
        home_team_logo: match.home_team_logo,
        away_team_logo: match.away_team_logo,
        match_date: match.match_date,
        prediction_deadline: match.prediction_deadline,
        league: match.league,
        status: match.status,
        home_score: match.home_score,
        away_score: match.away_score,
        is_finished: ["FT", "AET", "PEN"].includes(match.status || ""),
      })) || []
    )
  } catch (error) {
    console.error("Error getting matches from database:", error)
    return []
  }
}

export { MAJOR_LEAGUES }
