require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET /index' do
    before do
      get '/posts' # Updated the URL to match the index action of the PostsController
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'correctly renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'contains the placeholder text' do
      expect(response.body).to include('List of Posts')
    end
  end

  describe 'GET /show' do
    before do
      get '/posts/1' # Updated the URL to match the show action of the PostsController
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'correctly renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'contains the placeholder text' do
      expect(response.body).to include('Post Details')
    end
  end
end
