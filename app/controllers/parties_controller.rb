class PartiesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

	def index
		@parties = Party.all
		render json: @parties.to_json
	end

	def show
		@party = Party.find(params[:id])
		render json: @party
	end

	def search
		@videos = $youtube.search(params[:songpull])
		render json: @videos.to_json
	end

	def create
		@party = current_user.parties.new(party_params)

		if @party.save
			render json: @party
		else
			render json: { errors: @party.errors.full_messages }
		end
	end

	def destroy
		@party = Party.find(params[:id])

		if @party.destroy && current_user.owns?(@party)
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
