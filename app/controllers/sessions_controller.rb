class SessionsController < ApplicationController
	def create
		@user = User.omniauth(params)
		render json: @user.to_json
	end
end
