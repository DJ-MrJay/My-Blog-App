require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryBot.build(:like) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    let(:like) { FactoryBot.create(:like) }

    it 'updates the post likes count after save' do
      expect { like }.to change { like.post.likes_count }.to(1)
    end
  end
end
