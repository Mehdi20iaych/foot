"use server"

import { createClient } from "@/lib/supabase/server"
import { revalidatePath } from "next/cache"

export async function submitPrediction(prevState: any, formData: FormData) {
  const matchId = formData.get("matchId")
  const homeScore = formData.get("homeScore")
  const awayScore = formData.get("awayScore")

  if (!matchId || homeScore === null || awayScore === null) {
    return { error: "Missing required fields" }
  }

  const homeScoreNum = Number.parseInt(homeScore.toString())
  const awayScoreNum = Number.parseInt(awayScore.toString())

  if (isNaN(homeScoreNum) || isNaN(awayScoreNum) || homeScoreNum < 0 || awayScoreNum < 0) {
    return { error: "Invalid score values" }
  }

  const supabase = createClient()

  try {
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser()

    if (authError || !user) {
      return { error: "Authentication required" }
    }

    await supabase.from("users").upsert(
      {
        id: user.id,
        email: user.email,
        display_name: user.user_metadata?.display_name || user.email?.split("@")[0] || "Anonymous",
        username: user.user_metadata?.username || user.email?.split("@")[0] || "user",
        updated_at: new Date().toISOString(),
      },
      {
        onConflict: "id",
      },
    )

    const { data: match } = await supabase.from("matches").select("prediction_deadline, id").eq("id", matchId).single()

    if (!match) {
      return { error: "Match not found" }
    }

    if (new Date() > new Date(match.prediction_deadline)) {
      return { error: "Prediction deadline has passed" }
    }

    // Determine predicted result
    let predictedResult = "draw"
    if (homeScoreNum > awayScoreNum) {
      predictedResult = "home_win"
    } else if (awayScoreNum > homeScoreNum) {
      predictedResult = "away_win"
    }

    const { error } = await supabase.from("predictions").upsert({
      user_id: user.id, // Use authenticated user ID
      match_id: match.id,
      predicted_home_score: homeScoreNum,
      predicted_away_score: awayScoreNum,
      predicted_result: predictedResult,
      updated_at: new Date().toISOString(),
    })

    if (error) {
      console.error("Prediction error:", error)
      return { error: "Failed to save prediction" }
    }

    // Update user's total predictions count
    await supabase.rpc("increment_user_predictions", { user_id: user.id })

    revalidatePath("/")
    return { success: true }
  } catch (error) {
    console.error("Prediction submission error:", error)
    return { error: "An unexpected error occurred" }
  }
}
