class AuthController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def create
    user = User.find_by(username: params[:username])
    is_authenticated = user.authenticate(params[:password]) if user
    # byebug
    if is_authenticated
      payload = { user_id: user.id}
      token = JWT.encode(payload, 'purple1994', 'HS256')
      #hs256 is the algorithim that turns the token into a string
      #if you are using javascript web tokens, for every time you talk to your server...
      #the first step will be establishing its you by creating an account or logging in which you end up getting a token
      #second step every time u talk to the server you send the token back with every request you make in the header using the key authorization which passes the token back
      #the request is being sent to the server
      #request.header["Authorization"]
      render json: { token: token, username: user.username, user_id: user.id, name: user.name, email: user.email }
    else
      render json: { errors: ["Incorrect username or password. Please try again."] }, status: :unprocessable_entity
    end
  end

end

#what is a single page application?
#it is an application in which the page doesnt reload
