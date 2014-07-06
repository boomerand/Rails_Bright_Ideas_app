class LikesController < ApplicationController
  def index
  end

  def show
    # render :text => params.inspect
    @idea = Idea.find(params[:id])
    @likes = Like.where(idea_id: params[:id])
  end

  def create
    # render :text => params.inspect
    user = User.find(session[:user_id])
    #check to see if logged in user has already liked the idea. If true, increment num_likes. If false, create new record.
    if existing_like = Like.exists?(user_id: session[:user_id], idea_id: params[:like][:idea_id])
      Like.where(user_id: session[:user_id], idea_id: params[:like][:idea_id]).first.increment!(:num_likes)
      redirect_to idea_path(user)
    else
      @like = User.find(session[:user_id]).likes.create(:idea_id => params[:like][:idea_id], :num_likes => 1)
      redirect_to idea_path(user)
    end
  end

  private
    def like_params
      params.require(:like).permit(:num_likes, :idea_id)
    end
end
