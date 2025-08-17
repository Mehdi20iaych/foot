"use client"

import { useState } from "react"
import { Card, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Clock, Target, Check } from "lucide-react"
import { submitPrediction } from "@/lib/prediction-actions"
import { useActionState } from "react"
import Image from "next/image"

interface PredictionCardProps {
  match: any
  userPrediction: any
  userId: string
}

export default function PredictionCard({ match, userPrediction, userId }: PredictionCardProps) {
  const [homeScore, setHomeScore] = useState(userPrediction?.predicted_home_score?.toString() || "")
  const [awayScore, setAwayScore] = useState(userPrediction?.predicted_away_score?.toString() || "")
  const [state, formAction] = useActionState(submitPrediction, null)

  const matchTime = new Date(match.match_date).toLocaleTimeString("en-US", {
    hour: "2-digit",
    minute: "2-digit",
  })

  const isPastDeadline = new Date() > new Date(match.prediction_deadline)
  const isFinished = match.is_finished || match.status === "FT"
  const hasPrediction = !!userPrediction

  const getResultBadge = () => {
    if (!isFinished || !userPrediction) return null

    if (userPrediction.exact_score_match) {
      return <Badge className="bg-green-100 text-green-800">Exact Score! +3 pts</Badge>
    } else if (userPrediction.result_match) {
      return <Badge className="bg-blue-100 text-blue-800">Correct Result! +1 pt</Badge>
    } else {
      return <Badge variant="secondary">No points</Badge>
    }
  }

  return (
    <Card className={`transition-all ${hasPrediction ? "border-emerald-200 bg-emerald-50/30" : ""}`}>
      <CardContent className="p-6">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center space-x-2">
            <div className="flex items-center space-x-2">
              {match.league_logo && (
                <Image
                  src={match.league_logo || "/placeholder.svg"}
                  alt={match.league}
                  width={20}
                  height={20}
                  className="rounded"
                />
              )}
              <Badge variant="outline">{match.league}</Badge>
            </div>
            <div className="flex items-center space-x-1 text-sm text-gray-500">
              <Clock className="h-4 w-4" />
              <span>{matchTime}</span>
            </div>
          </div>
          {getResultBadge()}
        </div>

        {/* Teams and scores */}
        <div className="flex items-center justify-between mb-6">
          <div className="flex-1 text-center">
            <div className="flex flex-col items-center space-y-2">
              {match.home_team_logo && (
                <Image
                  src={match.home_team_logo || "/placeholder.svg"}
                  alt={match.home_team}
                  width={40}
                  height={40}
                  className="rounded"
                />
              )}
              <div className="font-semibold text-lg">{match.home_team}</div>
            </div>
            {isFinished && <div className="text-2xl font-bold text-emerald-600 mt-2">{match.home_score}</div>}
          </div>

          <div className="px-4">
            <div className="text-gray-400 font-medium">VS</div>
          </div>

          <div className="flex-1 text-center">
            <div className="flex flex-col items-center space-y-2">
              {match.away_team_logo && (
                <Image
                  src={match.away_team_logo || "/placeholder.svg"}
                  alt={match.away_team}
                  width={40}
                  height={40}
                  className="rounded"
                />
              )}
              <div className="font-semibold text-lg">{match.away_team}</div>
            </div>
            {isFinished && <div className="text-2xl font-bold text-emerald-600 mt-2">{match.away_score}</div>}
          </div>
        </div>

        {/* Prediction form or display */}
        {isPastDeadline || hasPrediction ? (
          <div className="bg-gray-50 rounded-lg p-4">
            <div className="flex items-center justify-center space-x-4">
              <div className="text-center">
                <div className="text-sm text-gray-500">Your Prediction</div>
                <div className="text-xl font-bold text-gray-900">
                  {userPrediction?.predicted_home_score || "?"} - {userPrediction?.predicted_away_score || "?"}
                </div>
              </div>
              {hasPrediction && <Check className="h-5 w-5 text-emerald-600" />}
            </div>
            {isPastDeadline && !hasPrediction && (
              <p className="text-center text-sm text-gray-500 mt-2">Prediction deadline passed</p>
            )}
          </div>
        ) : (
          <form action={formAction} className="space-y-4">
            <input type="hidden" name="matchId" value={match.id} />

            <div className="flex items-center justify-center space-x-4">
              <div className="text-center">
                <label className="block text-sm font-medium text-gray-700 mb-2">{match.home_team}</label>
                <Input
                  type="number"
                  min="0"
                  max="20"
                  value={homeScore}
                  onChange={(e) => setHomeScore(e.target.value)}
                  name="homeScore"
                  className="w-16 text-center text-lg font-semibold"
                  placeholder="0"
                />
              </div>

              <div className="text-gray-400 font-bold text-xl">-</div>

              <div className="text-center">
                <label className="block text-sm font-medium text-gray-700 mb-2">{match.away_team}</label>
                <Input
                  type="number"
                  min="0"
                  max="20"
                  value={awayScore}
                  onChange={(e) => setAwayScore(e.target.value)}
                  name="awayScore"
                  className="w-16 text-center text-lg font-semibold"
                  placeholder="0"
                />
              </div>
            </div>

            {state?.error && <div className="text-red-600 text-sm text-center">{state.error}</div>}

            <Button
              type="submit"
              className="w-full bg-emerald-600 hover:bg-emerald-700"
              disabled={!homeScore || !awayScore}
            >
              <Target className="h-4 w-4 mr-2" />
              Submit Prediction
            </Button>
          </form>
        )}
      </CardContent>
    </Card>
  )
}
