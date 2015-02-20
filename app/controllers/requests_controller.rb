class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_request, only: [:played, :destroy, :like, :unlike]

  def destroy
    if current_user.owns?(@request) || current_user.owns?(@request.party)
      if @request.destroy
        Pusher[@request.party.id.to_s].trigger('request_destroyed', @request.to_json)
        render json: @request
      else
        render json: { errors: @requests.errors.full_messages }
      end
    end
  end

  def create
    @request = current_user.requests.new(request_params)

    if @request.save
      Pusher[@request.party.id.to_s].trigger('request_created', @request.to_json)
      render json: @requests
    else
      render json: { errors: @request.errors.full_messages }
    end
  end

  def played
    if current_user.owns?(@request.party)
      @request.played!
      Pusher[@request.party.id.to_s].trigger('request_played', @request.to_json)
      render json: @request
    end
  end

  def like
    current_user.likes.create(request: @request)
    Pusher[@request.party.id.to_s].trigger('request_liked', @request.to_json)
    render json: @request
  end

  def unlike
    @like = @request.likes.where(user_id: current_user.id).first
    if current_user.owns?(@like)
      if @like.destroy
        Pusher[@request.party.id.to_s].trigger('request_unliked', @request.to_json)
        render json: @request
      else
        render json: { errors: @like.errors.full_messages } 
      end
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
