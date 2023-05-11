require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_count).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:likes).with_foreign_key('author_id') }
    it { should have_many(:comments).through(:posts) }
  end

  describe '#recent_posts' do
    let(:user) { FactoryBot.create(:user_with_posts) }

    it 'returns the three most recent posts' do
      expect(user.recent_posts).to eq(user.posts.order(created_at: :desc).limit(3))
    end
  end
end