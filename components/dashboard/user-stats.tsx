import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Trophy, Flame } from "lucide-react"

interface UserStatsProps {
  user: any
}

export default function UserStats({ user }: UserStatsProps) {
  const accuracyColor = (accuracy: number) => {
    if (accuracy >= 80) return "text-green-600"
    if (accuracy >= 60) return "text-yellow-600"
    return "text-red-600"
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center space-x-2">
          <Trophy className="h-5 w-5 text-yellow-500" />
          <span>Your Stats</span>
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="text-center p-3 bg-emerald-50 rounded-lg">
            <div className="text-2xl font-bold text-emerald-600">{user?.current_streak || 0}</div>
            <div className="text-sm text-gray-600 flex items-center justify-center">
              <Flame className="h-4 w-4 mr-1" />
              Current Streak
            </div>
          </div>

          <div className="text-center p-3 bg-blue-50 rounded-lg">
            <div className="text-2xl font-bold text-blue-600">{user?.total_points || 0}</div>
            <div className="text-sm text-gray-600 flex items-center justify-center">
              <Trophy className="h-4 w-4 mr-1" />
              Total Points
            </div>
          </div>
        </div>

        <div className="space-y-3">
          <div className="flex justify-between items-center">
            <span className="text-sm text-gray-600">Predictions Made</span>
            <Badge variant="secondary">{user?.total_predictions || 0}</Badge>
          </div>

          <div className="flex justify-between items-center">
            <span className="text-sm text-gray-600">Correct Predictions</span>
            <Badge variant="secondary">{user?.correct_predictions || 0}</Badge>
          </div>

          <div className="flex justify-between items-center">
            <span className="text-sm text-gray-600">Accuracy</span>
            <Badge variant="secondary" className={accuracyColor(user?.prediction_accuracy || 0)}>
              {user?.prediction_accuracy || 0}%
            </Badge>
          </div>

          <div className="flex justify-between items-center">
            <span className="text-sm text-gray-600">Longest Streak</span>
            <Badge variant="secondary" className="text-orange-600">
              {user?.longest_streak || 0}
            </Badge>
          </div>
        </div>
      </CardContent>
    </Card>
  )
}
