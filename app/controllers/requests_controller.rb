class RequestsController < ApplicationController
  def destroy
    @request = Request.find(params[:id])
    if @request.destroy
      render json: @request
    else
      render json: { errors: @request.errors.full_messages }
    end
  end

  def create
    # if current_user
    #   @request = current_user.requests.new(request_params)
    # else
    #   @request = Request.new(request_params)
    # end
    @request = Request.new(request_params)

    if @request.save
      render json: @request
    else
      render json: { errors: @request.errors.full_messages }
    end
  end

  def played
    @request = Request.find(params[:request_id])
    @request.played!
    render json: @request
  end

  private
    def request_params
      params.require(:request).permit(:title, :author, :url, :party_id, :thumbnail)
    end
end
