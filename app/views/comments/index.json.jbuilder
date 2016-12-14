json.array!(@comments) do |comment|
  json.extract! comment, :id, :comment_user, :user_id, :like_comment, :dislike
  json.url comment_url(comment, format: :json)
end
