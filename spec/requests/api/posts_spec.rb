require 'swagger_helper'

RSpec.describe 'api/endpoints', type: :request, host: 'http://localhost:3000' do
  path '/api/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'

    get 'Retrieves all posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Access token', required: true

      response '200', 'OK' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/Post' }

        before do
          # Replace with appropriate authorization setup (e.g., Devise, JWT, etc.)
          headers = { 'Authorization' => 'Bearer YOUR_ACCESS_TOKEN' }
          request.headers.merge!(headers)
        end

        let(:user_id) { '2' }
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/Error'
        let(:user_id) { 'replace_with_user_id' }
        run_test!
      end

      response '404', 'User Not Found' do
        schema '$ref' => '#/components/schemas/Error'
        let(:user_id) { 'invalid_user_id' }
        run_test!
      end
    end
  end
end
