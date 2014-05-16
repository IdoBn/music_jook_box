class SessionsController < ApplicationController
	def create
		@user = User.omniauth(params)
		session[:user_id] = @user.id
		render json: @user
	end

	def destroy
		session[:user_id] = nil
	end
end
