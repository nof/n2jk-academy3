class UserMailer < ApplicationMailer

  def post_created(post)
    @post = post
    mail(to: User.all.map(&:email), subject: "[n2jk-academy] #{@post.user.name}が週報を投稿しました")
  end

end
