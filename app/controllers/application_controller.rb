class ApplicationController < ActionController::API
	def current_user
	  @current_user ||= User.where(access_token: params[:user_access_token]).first if params[:user_access_token]
	end
	helper_method :current_user

	def authenticate_user!
		unless current_user
			render :json => {error: 'un authorized'}, :status => :unauthorized
		end
	end
end
