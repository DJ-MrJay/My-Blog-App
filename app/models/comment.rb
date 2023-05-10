class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_save :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_count: post.comments.count)
  end
end
