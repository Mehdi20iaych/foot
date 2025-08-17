import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation"
import DashboardHeader from "@/components/dashboard/dashboard-header"
import LeaderboardTabs from "@/components/social/leaderboard-tabs"

export default async function LeaderboardPage() {
  const supabase = createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect("/auth/login")
  }

  // Get user profile
  const { data: userProfile } = await supabase.from("users").select("*").eq("id", user.id).single()

  // Get top users by total points
  const { data: topByPoints } = await supabase
    .from("users")
    .select("id, username, display_name, avatar_url, total_points, current_streak, prediction_accuracy")
    .eq("is_active", true)
    .order("total_points", { ascending: false })
    .limit(50)

  // Get top users by current streak
  const { data: topByStreak } = await supabase
    .from("users")
    .select("id, username, display_name, avatar_url, total_points, current_streak, prediction_accuracy")
    .eq("is_active", true)
    .order("current_streak", { ascending: false })
    .limit(50)

  // Get top users by accuracy (minimum 10 predictions)
  const { data: topByAccuracy } = await supabase
    .from("users")
    .select(
      "id, username, display_name, avatar_url, total_points, current_streak, prediction_accuracy, total_predictions",
    )
    .eq("is_active", true)
    .gte("total_predictions", 10)
    .order("prediction_accuracy", { ascending: false })
    .limit(50)

  return (
    <div className="min-h-screen bg-gray-50">
      <DashboardHeader user={userProfile} />

      <main className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Leaderboard</h1>
          <p className="text-gray-600 mt-2">See how you stack up against other predictors</p>
        </div>

        <LeaderboardTabs
          topByPoints={topByPoints || []}
          topByStreak={topByStreak || []}
          topByAccuracy={topByAccuracy || []}
          currentUserId={user.id}
        />
      </main>
    </div>
  )
}
