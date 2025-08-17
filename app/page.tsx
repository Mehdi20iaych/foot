import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation"
import DashboardHeader from "@/components/dashboard/dashboard-header"
import TodaysPredictions from "@/components/predictions/todays-predictions"
import { getTodaysMatches } from "@/lib/api-football"

export default async function HomePage() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!supabaseUrl || !supabaseAnonKey) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="max-w-md mx-auto text-center p-8 bg-white rounded-lg shadow-lg">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Setup Required</h1>
          <p className="text-gray-600 mb-6">
            This app requires Supabase to be configured. Please set up your Supabase integration to continue.
          </p>
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 text-left">
            <h3 className="font-semibold text-blue-900 mb-2">Setup Steps:</h3>
            <ol className="text-sm text-blue-800 space-y-1">
              <li>1. Click the gear icon (⚙️) in the top right</li>
              <li>2. Go to "Project Settings"</li>
              <li>3. Add the Supabase integration</li>
              <li>4. Run the database scripts provided</li>
            </ol>
          </div>
        </div>
      </div>
    )
  }

  let supabase
  try {
    supabase = createClient()
  } catch (error) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="max-w-md mx-auto text-center p-8 bg-white rounded-lg shadow-lg">
          <h1 className="text-2xl font-bold text-red-600 mb-4">Configuration Error</h1>
          <p className="text-gray-600 mb-4">
            There was an error connecting to Supabase. Please check your configuration.
          </p>
          <p className="text-sm text-gray-500">Error: {error instanceof Error ? error.message : "Unknown error"}</p>
        </div>
      </div>
    )
  }

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect("/auth/login")
  }

  // Get user profile data
  let userProfile = null
  let todaysMatches = []
  let userPredictions = []

  try {
    // Get user profile data
    const { data: profileData } = await supabase.from("users").select("*").eq("id", user.id).single()
    userProfile = profileData

    // Get today's matches
    todaysMatches = await getTodaysMatches()

    // Only query predictions if we have matches with database IDs
    if (todaysMatches && todaysMatches.length > 0) {
      const dbMatchIds = todaysMatches.filter((m) => m.dbId).map((m) => m.dbId)
      if (dbMatchIds.length > 0) {
        const { data: predictionsData } = await supabase
          .from("predictions")
          .select("*")
          .eq("user_id", user.id)
          .in("match_id", dbMatchIds)
        userPredictions = predictionsData || []
      }
    }
  } catch (error) {
    console.log("[v0] Error loading data:", error)
    // Continue with empty data rather than crashing
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <DashboardHeader user={userProfile} />

      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <TodaysPredictions matches={todaysMatches || []} userPredictions={userPredictions || []} userId={user.id} />
      </main>
    </div>
  )
}
