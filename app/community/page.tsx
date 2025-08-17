import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation"
import DashboardHeader from "@/components/dashboard/dashboard-header"
import CommunityFeed from "@/components/social/community-feed"
import CreatePost from "@/components/social/create-post"

export default async function CommunityPage() {
  const supabase = createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect("/auth/login")
  }

  let { data: userProfile } = await supabase.from("users").select("*").eq("id", user.id).single()

  if (!userProfile) {
    // Create user profile if it doesn't exist
    const { data: newUser, error } = await supabase
      .from("users")
      .insert({
        id: user.id,
        email: user.email,
        username: user.email?.split("@")[0] || "user",
        display_name: user.user_metadata?.full_name || user.email?.split("@")[0] || "User",
        avatar_url: user.user_metadata?.avatar_url || null,
      })
      .select()
      .single()

    if (error) {
      console.error("Error creating user profile:", error)
      redirect("/auth/login")
    }

    userProfile = newUser
  }

  // Get recent posts with user info and engagement metrics
  const { data: posts } = await supabase
    .from("posts")
    .select(`
      *,
      users!posts_user_id_fkey(id, username, display_name, avatar_url),
      matches(home_team, away_team, league)
    `)
    .eq("is_hidden", false)
    .order("created_at", { ascending: false })
    .limit(20)

  return (
    <div className="min-h-screen bg-gray-50">
      <DashboardHeader user={userProfile} />

      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="space-y-6">
          <div className="text-center">
            <h1 className="text-3xl font-bold text-gray-900">Community Feed</h1>
            <p className="text-gray-600 mt-2">Share your predictions and celebrate with fellow fans</p>
          </div>

          <CreatePost userId={user.id} />
          <CommunityFeed posts={posts || []} currentUserId={user.id} />
        </div>
      </main>
    </div>
  )
}
