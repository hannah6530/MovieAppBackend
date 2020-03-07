class FavoritesController < ApplicationController
  def index
    # favorites = Favorite.all
    # render json: favorites, include:[:user]
    if params[:user_id] # from /users/:user_id/movies fetch request
      user = User.find_by(id: params[:user_id])
      if user
        favorites = user.favorites
      else
         "user not found"
      end
   else # from /movies fetch request
     favorites = Favorite.all
   end

     render json: {favorites: favorites}, include:[:user]
  end

  def create
    favorite = Favorite.create(favorite_params)
    render json: favorite
  end
  #
  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    render json: favorite
  end
  def show
    favorites = Favorite.find(params[:id])
    render json: favorites
  end
private

def favorite_params
    params.permit(:user_id, :movie_id)
end

end
