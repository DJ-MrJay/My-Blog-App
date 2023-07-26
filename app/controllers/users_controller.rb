class UsersController < ApplicationController
  def index
    @users = User.all.includes(:posts) # Eager loading posts for all users
  end

  def show
    @user = User.includes(posts: [{ comments: :author }]).find(params[:id]) # Eager loading posts, comments, and authors for the specific user
  end
end
