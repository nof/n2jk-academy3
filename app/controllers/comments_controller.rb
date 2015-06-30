class CommentsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      UserMailer.comment_created(self).deliver_later!
      redirect_to user_posts_url, notice: 'コメントしました'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_posts_url, notice: 'コメントを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_posts_url, notice: 'コメントを削除しました'
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
