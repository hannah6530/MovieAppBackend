class CommentsController < ApplicationController
  def index
    # comments = Comment.all
    # render json: comments, include:[:user]
    if params[:user_id] # from /users/:user_id/movies fetch request
      user = User.find_by(id: params[:user_id])
      if user
        comments = user.comments
      else
         "user not found"
      end
   else # from /movies fetch request
     comments = Comment.all
   end
     render json: {comments: comments}, include:[:user]
  end


  def create
    comment = Comment.create(comment_params)
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

private

def comment_params
    params.permit(:comment, :user_id)
end
end
