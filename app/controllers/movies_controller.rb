
class MoviesController < ApplicationController
def index
  # user = User.find_by(id: params[:user_id])
  # if user
  #   movies = user.movies
  # end
  # render json: movies, include:[:user]

    if params[:user_id] # from /users/:user_id/movies fetch request
      user = User.find_by(id: params[:user_id])
      if user
        movies = user.movies
      else
         "user not found"
      end
   else # from /movies fetch request
     movies = Movie.all
   end
     render json: {movies: movies}, include:[:user]
end

def destroy
  movie = Movie.find(params[:id])
  movie.destroy
  render json: movie
end

def show
  movies = Movie.find(params[:id])
  render json: movies
end

def create
  movie = Movie.create(movie_params)
  # byebug
  render json: movie
end

private

def movie_params
  params.permit(:name, :genre, :rating, :image, :watch_link, :user_id)
end

end
