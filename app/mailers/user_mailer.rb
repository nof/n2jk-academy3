class UserMailer < ApplicationMailer

  def post_created(post)
    @post = post
    if tos = User.where.not(id: @post.user.id).map(&:email).presence
      mail(to: tos, subject: "[n2jk-academy] #{@post.user.name}が週報を投稿しました")
    end
  end

  def comment_created(comment)
    @comment = comment
    return if @comment.user == @comment.post.user
    mail(to: @comment.post.user.email, subject: "[n2jk-academy] #{@comment.user.name}がコメントしました")
  end

end
