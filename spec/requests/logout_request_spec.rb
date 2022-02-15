require 'rails_helper'

RSpec.describe 'Logout' do
  # Authentication test suite
  describe 'GET /auth/logout' do
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        #generate random email and password with Faker gem
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # returns auth token when request is valid
    context 'When request is valid' do
      before { 
        post '/auth/login',params: valid_credentials, headers: headers 
        request1 = get '/auth/logout', params: {Authorization: json['auth_token']}, headers: headers 
      }
       
      it 'returns status code 200' do
        expect(json['message']).not_to be_nil
        RSpec.describe json['message'] do
            it { is_expected.to match("Invalid credentials") }
            it { is_expected.not_to match("You have succesfully logged out...") }
        end 
      end
    end

    # returns failure message when request is invalid
    #context 'When request is invalid' do
     # before {
      #  request2 = get '/auth/logout', params: {Authorization: nil}.to_json, headers: headers
      #}
      #it 'returns a failure message' do
       # expect(json['message']).to match("Invalid token")
      #end
    #end
  end
end
