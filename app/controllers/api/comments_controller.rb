class Api::CommentsController < Api::ApplicationController
  before_action :set_incoming_post, only: [:index]
  before_action :set_incoming_author, only: [:index]

  def index
    comments = @post.comments.where(author: @author)
    render json: comments, status: :ok
  end

  def create
    # Use the currently logged-in user to create the comment
    @comment = Comment.new(author_id: params[:user_id], post_id: params[:post_id], **comment_params)

    if @comment.save
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_incoming_post
    @post = Post.find(params[:post_id])
  end

  def set_incoming_author
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
