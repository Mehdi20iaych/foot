"use client"

import { useState } from "react"
import { Card, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Textarea } from "@/components/ui/textarea"
import { MessageCircle, Send } from "lucide-react"
import { createPost } from "@/lib/social-actions"
import { useActionState } from "react"

interface CreatePostProps {
  userId: string
}

export default function CreatePost({ userId }: CreatePostProps) {
  const [content, setContent] = useState("")
  const [state, formAction] = useActionState(createPost, null)

  const handleSubmit = async (formData: FormData) => {
    await formAction(formData)
    if (!state?.error) {
      setContent("")
    }
  }

  return (
    <Card>
      <CardContent className="p-6">
        <form action={handleSubmit} className="space-y-4">
          <div className="flex items-start space-x-3">
            <div className="bg-emerald-100 p-2 rounded-full">
              <MessageCircle className="h-5 w-5 text-emerald-600" />
            </div>
            <div className="flex-1">
              <Textarea
                name="content"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                placeholder="Share your thoughts, predictions, or celebrate your wins..."
                className="min-h-[100px] resize-none border-gray-200 focus:border-emerald-300"
                maxLength={500}
              />
              <div className="flex items-center justify-between mt-3">
                <span className="text-sm text-gray-500">{content.length}/500</span>
                <Button
                  type="submit"
                  disabled={!content.trim() || content.length > 500}
                  className="bg-emerald-600 hover:bg-emerald-700"
                >
                  <Send className="h-4 w-4 mr-2" />
                  Post
                </Button>
              </div>
            </div>
          </div>

          {state?.error && <div className="text-red-600 text-sm">{state.error}</div>}
        </form>
      </CardContent>
    </Card>
  )
}
