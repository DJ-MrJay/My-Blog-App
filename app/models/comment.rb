class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_post_comments_counter

  validates :text, presence: true

  def update_post_comments_counter
    post.update_comments_counter
  end
end
