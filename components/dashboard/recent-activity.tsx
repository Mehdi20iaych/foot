import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Activity, Clock } from "lucide-react"

interface RecentActivityProps {
  userId: string
}

export default function RecentActivity({ userId }: RecentActivityProps) {
  // This would typically fetch recent predictions/activities from the database
  // For now, showing placeholder content

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center space-x-2">
          <Activity className="h-5 w-5 text-blue-500" />
          <span>Recent Activity</span>
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-3">
          <div className="text-center py-8 text-gray-500">
            <Clock className="h-8 w-8 mx-auto mb-2 text-gray-400" />
            <p className="text-sm">No recent activity</p>
            <p className="text-xs text-gray-400 mt-1">Make your first prediction to see activity here</p>
          </div>
        </div>
      </CardContent>
    </Card>
  )
}
