class SessionsController < ApplicationController
	def create
		@user = User.omniauth(params)
		render json: @user
	end
end
