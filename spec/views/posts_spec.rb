require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before(:example) do
    # Create a test user with a name, photo, and bio
    @user = User.create(name: 'Jane Doe',
                        photo: 'https://images.pexels.com/photos/6019152/pexels-photo-6019152.jpeg',
                        bio: 'Fashion icon from South Africa')

    # Create a test post associated with the test user
    @post = Post.create(title: 'title', text: 'content', author: @user)

    # Create a test comment associated with the test post and the test user
    @comment = Comment.create(text: 'comment', post: @post, author: @user)

    # Create a test like associated with the test post and the test user
    @like = Like.create(post: @post, author: @user)
  end

  describe 'GET /posts' do
    before(:example) do
      # Visit the user's posts page
      visit user_posts_path(@user)
    end

    # Test: Verify that the user's image is visible
    it 'displays the user image' do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    # Test: Verify that the username is visible
    it 'displays the username' do
      expect(page).to have_content('Jane Doe')
    end

    # Test: Verify that the number of posts is visible
    it 'displays the number of posts' do
      expect(page).to have_content('Number of posts: 1')
    end

    # Test: Verify that the post title is visible
    it 'displays the post title' do
      expect(page).to have_content('title')
    end

    # Test: Verify that the post content is visible
    it 'displays the post content' do
      expect(page).to have_content('content')
    end

    # Test: Verify that the first comment is visible
    it 'displays the first comment' do
      expect(page).to have_content('comment')
    end

    # Test: Verify that the number of comments is visible
    it 'displays the number of comments' do
      expect(page).to have_content('Comments: 1')
    end

    # Test: Verify that the number of likes is visible
    it 'displays the number of likes' do
      expect(page).to have_content('Likes: 1')
    end

    # Test: Verify that clicking on the post title leads to the post page
    it 'navigates to the post page when the post title is clicked' do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end
  end

  describe 'GET /posts/:id' do
    before(:example) do
      # Visit the specific post page
      visit user_post_path(@user, @post)
    end

    # Test: Verify that the post title is visible on the post page
    it 'displays the post title' do
      expect(page).to have_content('title')
    end

    # Test: Verify that the post author's name is visible on the post page
    it "displays the post author's name" do
      expect(page).to have_content('Jane Doe')
    end

    # Test: Verify that the number of comments for the post is visible
    it 'displays the number of comments for the post' do
      expect(page).to have_content('Comments: 1')
    end

    # Test: Verify that the number of likes for the post is visible
    it 'displays the number of likes for the post' do
      expect(page).to have_content('Likes: 1')
    end

    # Test: Verify that the post content is visible on the post page
    it 'displays the post content' do
      expect(page).to have_content('content')
    end

    # Test: Verify that the username of the comment's author is visible on the post page
    it "displays the username of the comment's author" do
      expect(page).to have_content(@comment.author.name)
    end

    # Test: Verify that the comment's content is visible on the post page
    it "displays the comment's content" do
      expect(page).to have_content(@comment.text)
    end
  end
end
