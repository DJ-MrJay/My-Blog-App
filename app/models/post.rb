class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :text, presence: true

  def update_posts_counter
    update(posts_count: likes.count + comments.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
