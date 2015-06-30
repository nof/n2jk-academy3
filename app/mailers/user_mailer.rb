class UserMailer < ApplicationMailer

  def post_created(post)
    @post = post
    mail(to: User.where.not(user: @post.user).map(&:email), subject: "[n2jk-academy] #{@post.user.name}が週報を投稿しました")
  end

  def comment_created(comment)
    @comment = comment
    return if @comment.user == @comment.post.user
    mail(to: @comment.post.user.email, subject: "[n2jk-academy] #{@comment.user.name}がコメントしました")
  end

end
