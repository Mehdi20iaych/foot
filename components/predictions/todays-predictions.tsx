"use client"

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Calendar } from "lucide-react"
import PredictionCard from "./prediction-card"

interface TodaysPredictionsProps {
  matches: any[]
  userPredictions: any[]
  userId: string
}

export default function TodaysPredictions({ matches, userPredictions, userId }: TodaysPredictionsProps) {
  const today = new Date().toLocaleDateString("en-US", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  })

  if (!matches || matches.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Calendar className="h-5 w-5 text-emerald-600" />
            <span>Today's Predictions</span>
          </CardTitle>
          <CardDescription>{today}</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="text-center py-8">
            <p className="text-gray-500">No matches scheduled for today.</p>
            <p className="text-sm text-gray-400 mt-2">Check back tomorrow for new predictions!</p>
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="flex items-center space-x-2">
              <Calendar className="h-5 w-5 text-emerald-600" />
              <span>Today's Predictions</span>
            </CardTitle>
            <CardDescription>{today}</CardDescription>
          </div>
          <Badge variant="secondary" className="bg-emerald-100 text-emerald-700">
            {matches.length} {matches.length === 1 ? "Match" : "Matches"}
          </Badge>
        </div>
      </CardHeader>
      <CardContent className="space-y-4">
        {matches.map((match) => {
          const userPrediction = userPredictions.find((p) => p.match_id === match.id)
          return <PredictionCard key={match.id} match={match} userPrediction={userPrediction} userId={userId} />
        })}
      </CardContent>
    </Card>
  )
}
