require 'swagger_helper'

describe 'Todos API' do

  # Initialize the test data
  let!(:test_user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: test_user.id) }
  let(:todo_id) { todos.first.id }

  path '/todos' do

    get 'List all todos.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]

      response '200', 'User\'s todo list returned.' do
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end

    post 'Create a new todo.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :todo, in: :body, required: true, description: 'Todo\'s fields.', schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: ['title']
      }

      response '201', 'Todo created.' do
        let(:todo) { { title: 'Foo' } }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid token, missing token or invalid request.' do
        let(:todo) { {  } }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end
    end
  end

  path '/todos/{id}' do

    get 'Get a todo.' do 
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :id, in: :path, type: :integer, description: 'Todo\'s id.', required: true

      response '200', 'Todo returned.' do
        let(:id) { todo_id }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo does not exist.' do
        let(:id) { 0 }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:id) { todo_id }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end

    put 'Update a todo.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :todo, in: :body, required: true, description: 'Todo\'s fields.', schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: ['title']
      }

      response '204', 'Todo updated.' do
        let(:id) { todo_id }
        let(:todo) { { title: todos.first.title + 'bar' } }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo does not exist.' do
        let(:id) { 0 }
        let(:todo) { { title: todos.first.title + 'bar' } }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:id) { todo_id }
        let(:todo) { { title: todos.first.title + 'bar' } }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end

    delete 'Delete a todo and its items.' do

      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :id, in: :path, type: :integer, description: 'Todo\'s id.', required: true

      response '204', 'Todo deleted, along with its items.' do
        let(:id) { todo_id }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo does not exist.' do
        let(:id) { 0 }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:id) { todos.last.id }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end
  end
end
