class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    # Eager loading posts for all users
    @users = User.all.includes(:posts)
  end

  def show
    # Eager loading posts, comments, and authors for the specific user
    @user = User.includes(posts: [{ comments: :author }]).find(params[:id])
  end
end
