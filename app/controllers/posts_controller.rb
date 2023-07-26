class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :likes) # Eager loading comments and likes for the user's posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments, :likes).find(params[:id]) # Eager loading comments and likes for the specific post
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

    if @post.save
      @post.update_user_posts_counter
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash[:notice] = 'Sorry, post was not created successfully'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end
