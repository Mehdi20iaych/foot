"use server"

import { createClient } from "@/lib/supabase/server"
import { revalidatePath } from "next/cache"

export async function createPost(prevState: any, formData: FormData) {
  const supabase = createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return { error: "You must be logged in to create a post" }
  }

  const content = formData.get("content")

  if (!content) {
    return { error: "Post content is required" }
  }

  const contentStr = content.toString().trim()
  if (contentStr.length === 0 || contentStr.length > 500) {
    return { error: "Post content must be between 1 and 500 characters" }
  }

  try {
    const { error: userError } = await supabase.from("users").upsert(
      {
        id: user.id,
        email: user.email,
        username: user.email?.split("@")[0] || "user",
        display_name: user.user_metadata?.full_name || user.email?.split("@")[0] || "User",
        avatar_url: user.user_metadata?.avatar_url || null,
        is_active: true,
        total_points: 0,
        total_predictions: 0,
        correct_predictions: 0,
        current_streak: 0,
        longest_streak: 0,
        prediction_accuracy: 0,
        notification_preferences: {},
      },
      {
        onConflict: "id",
      },
    )

    if (userError) {
      console.error("User creation error:", userError)
      return { error: "Failed to create user profile" }
    }

    const { error } = await supabase.from("posts").insert({
      user_id: user.id,
      content: contentStr,
      post_type: "general",
    })

    if (error) {
      console.error("Create post error:", error)
      return { error: "Failed to create post" }
    }

    revalidatePath("/community")
    return { success: true }
  } catch (error) {
    console.error("Create post error:", error)
    return { error: "An unexpected error occurred" }
  }
}

export async function likePost(prevState: any, formData: FormData) {
  const supabase = createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return { error: "You must be logged in to like posts" }
  }

  const postId = formData.get("postId")

  if (!postId) {
    return { error: "Post ID is required" }
  }

  try {
    // Check if user already liked this post
    const { data: existingLike } = await supabase
      .from("likes")
      .select("id")
      .eq("user_id", user.id)
      .eq("post_id", postId)
      .single()

    if (existingLike) {
      // Unlike the post
      await supabase.from("likes").delete().eq("user_id", user.id).eq("post_id", postId)

      // Decrement likes count
      await supabase.rpc("decrement_post_likes", { post_id: postId })
    } else {
      // Like the post
      await supabase.from("likes").insert({
        user_id: user.id,
        post_id: postId,
      })

      // Increment likes count
      await supabase.rpc("increment_post_likes", { post_id: postId })
    }

    revalidatePath("/community")
    return { success: true }
  } catch (error) {
    console.error("Like post error:", error)
    return { error: "An unexpected error occurred" }
  }
}
