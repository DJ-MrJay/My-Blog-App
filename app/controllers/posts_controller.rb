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
    @user = User.find(params[:user_id]) # Find the correct user based on the user_id in the URL
    @post = @user.posts.new(posts_params)

    if @post.save
      @post.update_user_posts_counter
      redirect_to user_post_path(@user, @post) # Redirect to the show page of the newly created post
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end
