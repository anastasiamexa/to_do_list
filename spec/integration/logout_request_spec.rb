require 'swagger_helper'

describe 'Authentication' do

  # create test user
  let!(:test_user) { create(:user) }

  path '/auth/logout' do

    post 'Logout.' do
      consumes 'application/json'
      produces 'application/json'
      description 'Log in to access the API.'
      parameter name: :user, in: :body, required: true, description: 'The fields that are required to log in.', schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '200', 'You have succesfully logged out...' do
        let(:user) do
          {
            email: test_user.email,
            password: test_user.password
          }
        end
        run_test!
      end
    end
  end
end
