class PostsController < ApplicationController
  def index
    # Placeholder action
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    # Placeholder action
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
