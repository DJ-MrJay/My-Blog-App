class LikesController < ApplicationController
  def create
    @post = Post.includes(:likes).find(params[:post_id]) # Eager loading the likes for the specific post
    @user = current_user
    @like = Like.new(author: @user, post: @post)
    @like.save
    redirect_to user_post_path(@user, @post)
  end
end
