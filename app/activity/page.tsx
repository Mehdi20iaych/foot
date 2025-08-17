import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation"
import DashboardHeader from "@/components/dashboard/dashboard-header"
import RecentActivity from "@/components/dashboard/recent-activity"

export default async function ActivityPage() {
  const supabase = createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect("/auth/login")
  }

  // Get user profile data
  const { data: userProfile } = await supabase.from("users").select("*").eq("id", user.id).single()

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <DashboardHeader user={userProfile} />

      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Recent Activity</h1>
          <p className="text-gray-600 dark:text-gray-400 mt-2">Your latest predictions and achievements</p>
        </div>

        <RecentActivity userId={user.id} />
      </main>
    </div>
  )
}
