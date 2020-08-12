class Api::V1::EvintsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  def index
    @evints = Evint.all
    # render json: @evints #Just for testing
    # implement search function later, write conditions here - if params[:query] == ?? return ....
  end

  def show
    @evint = Evint.find(params[:id])
  end

  private

  def evint_params
    params.require(:evint).permit(:title, :evint_link, :venue, :address, :lng, :lat, :category, :time, :description, :image_link, :date, :wechatid)
  end
end
