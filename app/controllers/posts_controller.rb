class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = @post.comments
    @likes = @post.likes
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(posts_params)

    if @post.save
      @post.update_post_counter
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def posts_params
    params.require(:posts).permit(:title, :text)
  end
end
