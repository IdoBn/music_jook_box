class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_request, only: [:played, :destroy]

  def destroy
    if current_user.owns?(@request) || current_user.owns?(@request.party)
      if @request.destroy
        render json: @requests
      else
        render json: { errors: @requests.errors.full_messages }
      end
    end
  end

  def create
    @request = current_user.requests.new(request_params)

    if @request.save
      render json: @requests
    else
      render json: { errors: @request.errors.full_messages }
    end
  end

  def played
    if current_user.owns?(@request.party)
      @request.played!
      render json: @requests
    end
  end

  private
    def request_params
      params.require(:request).permit(:title, :author, :url, :party_id, :thumbnail)
    end

    def load_request
      @request = Request.find(params[:id])
    end
end
