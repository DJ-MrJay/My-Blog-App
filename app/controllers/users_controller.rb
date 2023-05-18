class UsersController < ApplicationController
  def index
    # Placeholder action
    @users = User.all
  end

  def show
    # Placeholder action
    @user = User.find(params[:id])
  end
end
