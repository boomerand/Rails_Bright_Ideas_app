class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@ideas = User.find(params[:id]).ideas.all
		@likes = User.find(params[:id]).likes.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "User profile successfully created. Login to view your profile."
			redirect_to new_user_path
		else
			flash[:errors] = @user.errors.full_messages	
			redirect_to new_user_path
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
		end
end
