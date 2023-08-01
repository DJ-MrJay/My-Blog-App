class Api::PostsController < Api::ApplicationController
  before_action :incoming_author, only: [:index]

  def index
    posts = author.posts
    render json: posts, status: :ok
  end

  private

  def incoming_author
    @author = User.find(params[:user_id])
  end
end
