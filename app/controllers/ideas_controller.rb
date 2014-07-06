class IdeasController < ApplicationController
  def show
    @user = User.find(params[:id])
    @idea = Idea.new
    @ideas = Idea.all
    @like = Like.new
  end

  def create
    # render :text => session[:user_id]
    user = User.find(session[:user_id])
    @idea = User.find(session[:user_id]).ideas.new(idea_params)
    if @idea.save
      redirect_to idea_path(user)
    end
  end

  def destroy
    # render :text => params.inspect
    user = User.find(session[:user_id])
    delete_idea = Idea.find(params[:id]).destroy
    redirect_to idea_path(user)
  end

  private
    def idea_params
      params.require(:idea).permit(:description, :user_id)
    end
end
