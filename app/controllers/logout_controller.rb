class LogoutController < ApplicationController
  skip_before_action :authorize_request, only: :logout

  def logout
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    respose =  json_response(message: "You have succesfully logged out...")
    return response
  end


  private

  def auth_params
    params.permit(:email, :password)
  end
end
