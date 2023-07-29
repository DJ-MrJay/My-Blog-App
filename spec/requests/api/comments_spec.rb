require 'swagger_helper'

RSpec.describe 'api/endpoints', type: :request, host: 'http://localhost:3000' do
  path '/api/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

    get 'Retrieves comments for a specific post and user' do
      tags 'Comments'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Access token', required: true

      response '200', 'OK' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/Comment' }

        before do
          # Replace with appropriate authorization setup (e.g., Devise, JWT, etc.)
          headers = { 'Authorization' => 'Bearer YOUR_ACCESS_TOKEN' }
          request.headers.merge!(headers)
        end

        let(:user_id) { 'replace_with_user_id' }
        let(:post_id) { 'replace_with_post_id' }
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/Error'
        let(:user_id) { 'replace_with_user_id' }
        let(:post_id) { 'replace_with_post_id' }
        run_test!
      end

      response '404', 'User or Post Not Found' do
        schema '$ref' => '#/components/schemas/Error'
        let(:user_id) { 'invalid_user_id' }
        let(:post_id) { 'invalid_post_id' }
        run_test!
      end
    end

    post 'Creates a comment for a specific post and user' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Access token', required: true
      parameter name: :user_id, in: :path, type: :string, description: 'User ID'
      parameter name: :post_id, in: :path, type: :string, description: 'Post ID'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '200', 'OK' do
        schema '$ref' => '#/components/schemas/Comment'

        before do
          # Replace with appropriate authorization setup (e.g., Devise, JWT, etc.)
          headers = { 'Authorization' => 'Bearer YOUR_ACCESS_TOKEN' }
          request.headers.merge!(headers)
        end

        let(:user_id) { 'replace_with_user_id' }
        let(:post_id) { 'replace_with_post_id' }
        let(:comment) { { text: 'This is a comment.' } }
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/Error'
        let(:user_id) { 'replace_with_user_id' }
        let(:post_id) { 'replace_with_post_id' }
        let(:comment) { { text: 'This is a comment.' } }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema '$ref' => '#/components/schemas/Error'
        let(:user_id) { 'replace_with_user_id' }
        let(:post_id) { 'replace_with_post_id' }
        let(:comment) { { text: '' } } # Invalid comment without text
        run_test!
      end
    end
  end
end
