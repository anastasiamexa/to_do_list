require 'swagger_helper'

describe 'Items API' do

  # Initialize the test data
  let!(:test_user) { create(:user) }
  let!(:todo) { create(:todo, created_by: test_user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:item) { items.first }
  let(:item_id) { items.first.id }

  path '/todos/{todo_id}/items' do

    get 'List all todo\'s items.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :todo_id, in: :path, type: :integer, description: 'Todo\'s id.', required: true

      response '200', 'Todo\'s item list returned.' do
        let(:todo_id) { todo.id }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo does not exist.' do
        let(:todo_id) { 0 }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:todo_id) { todo.id }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end

    post 'Create a new todo item.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :todo_id, in: :path, type: :integer, description: 'Todo\'s id.', required: true
      parameter name: :todo_item, in: :body, required: true, description: 'Todo\'s fields.', schema: {
        type: :object,
        properties: {
          name: { type: :string },
          done: { type: :boolean }
        },
        required: ['name']
      }

      response '201', 'Todo item created.' do
        let(:todo_id) { todo.id }
        let(:todo_item) { item }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo does not exist.' do
        let(:todo_id) { 0 }
        let(:todo_item) { item }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid token, missing token or invalid request.' do
        let(:todo_id) { todo.id }
        let(:todo_item) {  }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end
    end
  end

  path '/todos/{todo_id}/items/{id}' do

    get 'Get a todo item.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :todo_id, in: :path, type: :integer, description: 'Todo\'s id.', required: true
      parameter name: :id, in: :path, type: :integer, description: 'Todo item\'s id.', required: true

      response '200', 'Todo item returned.' do
        let(:todo_id) { todo.id }
        let(:id) { item_id }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo or todo item does not exist.' do
        let(:todo_id) { todo.id }
        let(:id) { 0 }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:todo_id) { todo.id }
        let(:id) { item_id }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end

    put 'Update a todo item.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :todo_id, in: :path, type: :integer, description: 'Todo\'s id.', required: true
      parameter name: :id, in: :path, type: :integer, description: 'Todo item\'s id.', required: true
      parameter name: :todo_item, in: :body, required: true, description: 'Todo item\'s fields.', schema: {
        type: :object,
        properties: {
          name: { type: :string },
          done: { type: :boolean }
        }
      }

      response '204', 'Todo item updated.' do
        let(:todo_id) { todo.id }
        let(:id) { item_id }
        let(:todo_item) { { name: item.name + 'foo', done: true } }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo or todo item does not exist.' do
        let(:todo_id) { 0 }
        let(:id) { item_id }
        let(:todo_item) { { name: item.name + 'foo', done: true } }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:todo_id) { todo.id }
        let(:id) { item_id }
        let(:todo_item) { { name: item.name + 'foo', done: true } }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end

    delete 'Delete a todo item.' do
      consumes 'application/json'
      produces 'application/json'
      security [ Authorization: [] ]
      parameter name: :todo_id, in: :path, type: :integer, description: 'Todo\'s id.', required: true
      parameter name: :id, in: :path, type: :integer, description: 'Todo item\'s id.', required: true

      response '204', 'Todo item deleted.' do
        let(:todo_id) { todo.id }
        let(:id) { item_id }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '404', 'Todo or todo item does not exist.' do
        let(:todo_id) { todo.id }
        let(:id) { 0 }
        let(:Authorization) { token_generator(test_user.id) }
        run_test!
      end

      response '422', 'Invalid or missing token.' do
        let(:todo_id) { todo.id }
        let(:id) { item_id }
        let(:Authorization) { expired_token_generator(test_user.id) }
        run_test!
      end
    end
  end
end
