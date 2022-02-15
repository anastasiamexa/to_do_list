class LogoutUser
    def initialize(token)
        @token = token
    end

    def call()
        if @token != nil
        #json_response(auth_token: "")
        return {message: "You are now logged out...", status_code: '200'}.to_json
        else
            return {message: "Logout failed. Something went wrong.", status_code: '422'}.to_json
        end
    end
end
