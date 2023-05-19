require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /index' do
    before do
      get '/users'
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'correctly renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'contains the placeholder text' do
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET /show' do
    before do
      user = User.create(name: 'John Doe') # Creating a user for testing purposes
      get "/users/#{user.id}"
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'correctly renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'contains the placeholder text' do
      expect(response.body).to include('User Details')
    end
  end
end
