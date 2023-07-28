class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.includes(:comments).find(params[:post_id]) # Eager loading comments for the specific post
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
