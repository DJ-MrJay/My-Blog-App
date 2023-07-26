require 'rails_helper'

RSpec.describe 'Users', type: :feature do
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

  describe 'GET /users' do
    before(:example) do
      # Visit the users' page
      visit users_path
    end

    # Test: Verify that the usernames of all other users are visible
    it 'displays the usernames of all other users' do
      expect(page).to have_content('Jane Doe')
    end

    # Test: Verify that the profile pictures of each user are visible
    it 'displays the profile pictures of each user' do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    # Test: Verify that the number of posts each user has is visible
    it 'displays the number of posts each user has' do
      expect(page).to have_content('Number of posts: 1')
    end

    # Test: Verify that clicking on a user's name leads to their posts page
    it "navigates to the user's posts page when a user's name is clicked" do
      find("a[href='/users/#{@user.id}']").click
      sleep 1
      expect(current_path).to eq user_path(@user)
    end
  end

  describe 'GET /users/:id' do
    before(:example) do
      # Visit the specific user's page
      visit user_path(@user)
    end

    # Test: Verify that the user's profile picture is visible on the user's page
    it "displays the user's profile picture" do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    # Test: Verify that the user's name is visible on the user's page
    it "displays the user's name" do
      expect(page).to have_content('Jane Doe')
    end

    # Test: Verify that the number of posts the user has is visible on the user's page
    it 'displays the number of posts the user has' do
      expect(page).to have_content('Number of posts: 1')
    end

    # Test: Verify that the user's bio is visible on the user's page
    it "displays the user's bio" do
      expect(page).to have_content('Fashion icon from South Africa')
    end

    # Test: Verify that the first 3 posts of the user are visible on the user's page
    it "displays the user's first 3 posts" do
      @post2 = Post.create(title: 'title2', text: 'content2', author: @user)
      @post3 = Post.create(title: 'title3', text: 'content3', author: @user)
      @post4 = Post.create(title: 'title4', text: 'content4', author: @user)
      visit user_path(@user)
      expect(page.all('div.post-container a').count).to eq(3)
    end

    # Test: Verify that a button to see all of the user's posts is visible on the user's page
    it "displays a button to see all of the user's posts" do
      expect(page.find(:xpath, '//button[1]').text).to eq('See all posts')
    end

    # Test: Verify that clicking on a user's post leads to the post's show page
    it "navigates to the post's show page when a user's post is clicked" do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end

    # Test: Verify that clicking the button to see all of the user's posts leads to a page with all of the user's posts
    it "navigates to a page with all of the user's posts when the button is clicked" do
      find(:xpath, '//button[1]').click
      sleep 1
      expect(current_path).to eq user_path(@user)
    end
  end
end
