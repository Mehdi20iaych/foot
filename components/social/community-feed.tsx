"use client"

import { Card, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { Heart, MessageCircle, Clock } from "lucide-react"
import { likePost } from "@/lib/social-actions"
import { useActionState } from "react"

interface CommunityFeedProps {
  posts: any[]
  currentUserId: string
}

export default function CommunityFeed({ posts, currentUserId }: CommunityFeedProps) {
  if (!posts || posts.length === 0) {
    return (
      <Card>
        <CardContent className="p-8 text-center">
          <MessageCircle className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-gray-900 mb-2">No posts yet</h3>
          <p className="text-gray-500">Be the first to share something with the community!</p>
        </CardContent>
      </Card>
    )
  }

  return (
    <div className="space-y-6">
      {posts.map((post) => (
        <PostCard key={post.id} post={post} currentUserId={currentUserId} />
      ))}
    </div>
  )
}

function PostCard({ post, currentUserId }: { post: any; currentUserId: string }) {
  const [likeState, likeAction] = useActionState(likePost, null)

  const timeAgo = (date: string) => {
    const now = new Date()
    const postDate = new Date(date)
    const diffInHours = Math.floor((now.getTime() - postDate.getTime()) / (1000 * 60 * 60))

    if (diffInHours < 1) return "Just now"
    if (diffInHours < 24) return `${diffInHours}h ago`
    return `${Math.floor(diffInHours / 24)}d ago`
  }

  const getPostTypeBadge = (type: string) => {
    switch (type) {
      case "prediction":
        return <Badge className="bg-blue-100 text-blue-800">Prediction</Badge>
      case "celebration":
        return <Badge className="bg-green-100 text-green-800">Celebration</Badge>
      case "analysis":
        return <Badge className="bg-purple-100 text-purple-800">Analysis</Badge>
      default:
        return null
    }
  }

  return (
    <Card>
      <CardContent className="p-6">
        <div className="flex items-start space-x-4">
          <Avatar>
            <AvatarImage src={post.users?.avatar_url || "/placeholder.svg"} />
            <AvatarFallback className="bg-emerald-100 text-emerald-600">
              {(post.users?.display_name || post.users?.username)?.charAt(0).toUpperCase()}
            </AvatarFallback>
          </Avatar>

          <div className="flex-1">
            <div className="flex items-center space-x-2 mb-2">
              <h4 className="font-semibold text-gray-900">{post.users?.display_name || post.users?.username}</h4>
              {getPostTypeBadge(post.post_type)}
              <div className="flex items-center text-sm text-gray-500">
                <Clock className="h-4 w-4 mr-1" />
                {timeAgo(post.created_at)}
              </div>
            </div>

            {post.matches && (
              <div className="mb-3">
                <Badge variant="outline" className="text-xs">
                  {post.matches.league}: {post.matches.home_team} vs {post.matches.away_team}
                </Badge>
              </div>
            )}

            <p className="text-gray-700 mb-4 whitespace-pre-wrap">{post.content}</p>

            <div className="flex items-center space-x-4">
              <form action={likeAction}>
                <input type="hidden" name="postId" value={post.id} />
                <input type="hidden" name="userId" value={currentUserId} />
                <Button variant="ghost" size="sm" type="submit" className="text-gray-500 hover:text-red-500">
                  <Heart className="h-4 w-4 mr-1" />
                  {post.likes_count || 0}
                </Button>
              </form>

              <Button variant="ghost" size="sm" className="text-gray-500 hover:text-blue-500">
                <MessageCircle className="h-4 w-4 mr-1" />
                {post.comments_count || 0}
              </Button>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  )
}
