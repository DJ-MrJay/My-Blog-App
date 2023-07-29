class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    # Eager loading comments and likes for the user's posts
    @posts = @user.posts.includes(:comments, :likes)
  end

  def show
    @user = User.find(params[:user_id])
    # Eager loading comments and likes for the specific post
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(posts_params)
    @post.author = @user

    if @post.save
      @post.update_user_posts_counter
      flash[:notice] = 'Your post was created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      flash[:notice] = 'Sorry, post was not created.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    post = Post.find(params[:id])
    post.comments.destroy_all
    post.likes.destroy_all
    if post.destroy
      flash[:success] = 'Post deleted successfully.'
      redirect_to users_path
    else
      flash.now[:error] = 'Error: Post could not be deleted.'
      redirect_to users_path
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end
