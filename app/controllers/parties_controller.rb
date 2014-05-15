class PartiesController < ApplicationController
	def index
		@parties = Party.all
		render json: @parties.to_json
	end

	def show
		@party = Party.find(params[:id])
		render json: @party
	end

	def search
		client = YouTubeIt::Client.new(:dev_key => Rails.application.secrets.youtube_dev_key)
		@videos = client.videos_by(:query => params[:songpull], :per_page => 20 )
		render json: @videos
	end
end
