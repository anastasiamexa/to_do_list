require 'swagger_helper'

describe 'Users API' do

  path '/signup' do

    post 'Sign up.' do
      consumes 'application/json'
      produces 'application/json'
      description 'Sign up to access the API.'
      parameter name: :user, in: :body, required: true, description: 'The fields that are required to sign up.', schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: ['name', 'email', 'password', 'password_confirmation']
      }

      response '201', 'Account created successfully.' do
        let(:user) { { name: 'Foo', email: 'bar@gmail.com', password: 'foobar', password_confirmation: 'foobar' } }
        run_test!
      end

      response '422', 'Invalid request.' do
        let(:user) { { name: 'Foo', email: 'bar@gmail.com', password: 'foobar', password_confirmation: 'bar' } }
        run_test!
      end
    end
  end
end
