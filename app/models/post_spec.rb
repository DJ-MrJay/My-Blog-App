require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_presence_of(:text) }
    it { should validate_numericality_of(:comments_count).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_count).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#update_posts_counter' do
    let(:post) { FactoryBot.create(:post_with_likes_and_comments) }

    it 'updates the posts count' do
      expect { post.update_posts_counter }.to change { post.posts_count }.to(post.likes.count + post.comments.count)
    end
  end

  describe '#recent_comments' do
    let(:post) { FactoryBot.create(:post_with_comments) }

    it 'returns the five most recent comments' do
      expect(post.recent_comments).to eq(post.comments.order(created_at: :desc).limit(5))
    end
  end
end