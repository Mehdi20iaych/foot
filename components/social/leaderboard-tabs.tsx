"use client"

import { useState } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { Trophy, Flame, Target, Crown } from "lucide-react"

interface LeaderboardTabsProps {
  topByPoints: any[]
  topByStreak: any[]
  topByAccuracy: any[]
  currentUserId: string
}

export default function LeaderboardTabs({
  topByPoints,
  topByStreak,
  topByAccuracy,
  currentUserId,
}: LeaderboardTabsProps) {
  const [activeTab, setActiveTab] = useState("points")

  const tabs = [
    { id: "points", label: "Total Points", icon: Trophy, data: topByPoints },
    { id: "streak", label: "Current Streak", icon: Flame, data: topByStreak },
    { id: "accuracy", label: "Accuracy", icon: Target, data: topByAccuracy },
  ]

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Crown className="h-5 w-5 text-yellow-500" />
    if (rank === 2) return <Trophy className="h-5 w-5 text-gray-400" />
    if (rank === 3) return <Trophy className="h-5 w-5 text-amber-600" />
    return <span className="text-lg font-bold text-gray-500">#{rank}</span>
  }

  const getStatValue = (user: any, type: string) => {
    switch (type) {
      case "points":
        return user.total_points || 0
      case "streak":
        return user.current_streak || 0
      case "accuracy":
        return `${user.prediction_accuracy || 0}%`
      default:
        return 0
    }
  }

  const currentTab = tabs.find((tab) => tab.id === activeTab)

  return (
    <div className="space-y-6">
      {/* Tab buttons */}
      <div className="flex flex-wrap gap-2 justify-center">
        {tabs.map((tab) => {
          const Icon = tab.icon
          return (
            <Button
              key={tab.id}
              variant={activeTab === tab.id ? "default" : "outline"}
              onClick={() => setActiveTab(tab.id)}
              className={`flex items-center space-x-2 ${
                activeTab === tab.id ? "bg-emerald-600 hover:bg-emerald-700" : ""
              }`}
            >
              <Icon className="h-4 w-4" />
              <span>{tab.label}</span>
            </Button>
          )
        })}
      </div>

      {/* Leaderboard content */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            {currentTab && <currentTab.icon className="h-5 w-5 text-emerald-600" />}
            <span>Top Players - {currentTab?.label}</span>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {currentTab?.data.map((user, index) => {
              const rank = index + 1
              const isCurrentUser = user.id === currentUserId

              return (
                <div
                  key={user.id}
                  className={`flex items-center space-x-4 p-4 rounded-lg transition-colors ${
                    isCurrentUser ? "bg-emerald-50 border border-emerald-200" : "hover:bg-gray-50"
                  }`}
                >
                  <div className="flex items-center justify-center w-12">{getRankIcon(rank)}</div>

                  <Avatar>
                    <AvatarImage src={user.avatar_url || "/placeholder.svg"} />
                    <AvatarFallback className="bg-emerald-100 text-emerald-600">
                      {(user.display_name || user.username)?.charAt(0).toUpperCase()}
                    </AvatarFallback>
                  </Avatar>

                  <div className="flex-1">
                    <div className="flex items-center space-x-2">
                      <h4 className="font-semibold text-gray-900">{user.display_name || user.username}</h4>
                      {isCurrentUser && <Badge className="bg-emerald-100 text-emerald-800">You</Badge>}
                    </div>
                    <div className="flex items-center space-x-4 text-sm text-gray-500">
                      <span>{user.total_points || 0} points</span>
                      <span>{user.current_streak || 0} streak</span>
                      <span>{user.prediction_accuracy || 0}% accuracy</span>
                    </div>
                  </div>

                  <div className="text-right">
                    <div className="text-2xl font-bold text-emerald-600">{getStatValue(user, activeTab)}</div>
                    <div className="text-sm text-gray-500 capitalize">{activeTab}</div>
                  </div>
                </div>
              )
            })}

            {(!currentTab?.data || currentTab.data.length === 0) && (
              <div className="text-center py-8 text-gray-500">
                <Trophy className="h-12 w-12 mx-auto mb-4 text-gray-400" />
                <p>No rankings available yet</p>
                <p className="text-sm mt-1">Start making predictions to see the leaderboard!</p>
              </div>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
