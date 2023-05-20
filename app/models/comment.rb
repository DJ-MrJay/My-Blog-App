class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_comments_counter

  validates :text, presence: true

  def update_post_comments_counter
    post.update(comments_counter: Comment.where(post_id:).count)
  end
end
