class SessionsController < ApplicationController
  def new
  end

  def create
  	# render :text => params.inspect
  	@user = User.authenticate(params[:email], params[:password])
  	if @user.nil?
  		flash[:error] = "User account not found. Try again!"
  		redirect_to new_user_path
  	else
  		sign_in @user
  		redirect_to idea_path(@user)
  	end
  end

  def destroy
  	sign_out
  	redirect_to new_user_path
  end
end
