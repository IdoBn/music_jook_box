class PartiesController < ApplicationController
	before_action :authenticate_user!, only: [:create]

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

	def create
		@party = current_user.parties.new(party_params)

		if @party.save
			render json: @party
		else
			render json: { errors: @party.errors.full_messages }
		end
	end

private
	def party_params
		params.require(:party).permit(:name)
	end
end
