class UsersController < ApplicationController

  def index
    users = User.all
    render json: users, include:[:movies]
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.create(user_params)

    if user.valid?
      payload = { user_id: user.id }
      token = JWT.encode(payload, 'purple1994', 'HS256')
      #hs256 is the algorithim that turns the token into a string

      render json: { token: token, name: user.name, email: user.email, username: user.username, user_id: user.id  }

    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
   user = User.find(params[:id])
   user.update(user_params)
   render json: user
 end

 def destroy
   user = User.find(params[:id])
   user.destroy
   render json: user
 end

  def profile
    token = request.headers["Authorization"]
    decoded_token = JWT.decode(token, 'purple1994', true, { algorithim: 'HS256' })
    #the server will grab the token , decode it look up the information that was encoded with it
    #to find out what user you are then return the profile info of that user
    #only the server knows about the secret
    #the tokens are created with the secrets in context
    #the server uses the secret to endcode and decode information
    user_id = decoded_token[0]["user_id"]
    user = User.find(user_id)
    render json: user
  end

  private

  def user_params
    params.permit(:name, :email, :username, :password)
  end
end
