class UsersController < ApplicationController
  def show
    # Placeholder action
    @user = User.find(params[:id])
  end
end
