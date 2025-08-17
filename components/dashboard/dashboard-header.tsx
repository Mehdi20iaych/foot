import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Target, Trophy, Flame, LogOut, Users, MessageCircle, BarChart3, Activity } from "lucide-react"
import { signOut } from "@/lib/actions"
import Link from "next/link"

interface DashboardHeaderProps {
  user: any
}

export default function DashboardHeader({ user }: DashboardHeaderProps) {
  return (
    <header className="bg-gray-900 border-b border-gray-700 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo and title */}
          <div className="flex items-center space-x-4">
            <Link href="/" className="flex items-center space-x-4">
              <div className="bg-green-900 p-2 rounded-lg">
                <Target className="h-6 w-6 text-green-400" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-white">Football Predictions</h1>
                <p className="text-sm text-gray-400">Daily Contest</p>
              </div>
            </Link>
          </div>

          <nav className="hidden md:flex items-center space-x-6">
            <Link href="/" className="text-gray-300 hover:text-white font-medium transition-colors">
              Predictions
            </Link>
            <Link
              href="/stats"
              className="text-gray-300 hover:text-white font-medium transition-colors flex items-center space-x-1"
            >
              <BarChart3 className="h-4 w-4" />
              <span>Stats</span>
            </Link>
            <Link
              href="/activity"
              className="text-gray-300 hover:text-white font-medium transition-colors flex items-center space-x-1"
            >
              <Activity className="h-4 w-4" />
              <span>Activity</span>
            </Link>
            <Link
              href="/community"
              className="text-gray-300 hover:text-white font-medium transition-colors flex items-center space-x-1"
            >
              <MessageCircle className="h-4 w-4" />
              <span>Community</span>
            </Link>
            <Link
              href="/leaderboard"
              className="text-gray-300 hover:text-white font-medium transition-colors flex items-center space-x-1"
            >
              <Users className="h-4 w-4" />
              <span>Leaderboard</span>
            </Link>
          </nav>

          <div className="flex items-center space-x-4">
            {/* Quick stats */}
            <div className="hidden lg:flex items-center space-x-4">
              <div className="flex items-center space-x-1">
                <Flame className="h-4 w-4 text-orange-400" />
                <span className="text-sm font-medium text-white">{user?.current_streak || 0}</span>
              </div>
              <div className="flex items-center space-x-1">
                <Trophy className="h-4 w-4 text-yellow-400" />
                <span className="text-sm font-medium text-white">{user?.total_points || 0}</span>
              </div>
            </div>

            {/* User avatar and menu */}
            <div className="flex items-center space-x-3">
              <div className="text-right hidden sm:block">
                <p className="text-sm font-medium text-white">{user?.display_name || user?.username}</p>
                <p className="text-xs text-gray-400">
                  {user?.prediction_accuracy ? `${user.prediction_accuracy}% accuracy` : "New player"}
                </p>
              </div>
              <Avatar>
                <AvatarImage src={user?.avatar_url || "/placeholder.svg"} />
                <AvatarFallback className="bg-green-900 text-green-400">
                  {(user?.display_name || user?.username || user?.email)?.charAt(0).toUpperCase()}
                </AvatarFallback>
              </Avatar>

              <form action={signOut}>
                <Button
                  variant="ghost"
                  size="sm"
                  type="submit"
                  className="text-gray-300 hover:text-white hover:bg-gray-800"
                >
                  <LogOut className="h-4 w-4" />
                </Button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </header>
  )
}
