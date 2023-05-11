require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'Test Post', text: 'Lorem ipsum', author: user) }
  let(:comment) { Comment.new(text: 'Great post!', author: user, post:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(comment).to be_valid
    end

    it 'is not valid without a text' do
      comment.text = nil
      expect(comment).not_to be_valid
    end

    it 'is not valid without a post' do
      comment.post = nil
      expect(comment).not_to be_valid
    end
  end

  describe 'methods' do
    describe '#update_post_comments_counter' do
      it 'updates the post comments count' do
        expect { comment.save }.to change { post.reload.comments_count }.by(1)
      end
    end
  end
end
