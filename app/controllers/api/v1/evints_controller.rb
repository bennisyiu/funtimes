class Api::V1::EvintsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index ## used for both HOME and Add New Itinerary page
    if params[:query].present?
        @evints = search
    elsif params[:date].present? ## filter by date
      @evints = Evint.where(date: params[:date])
    else
      @evints = Evint.all
    end
    # since we have past events in the database, only display future events (from Date.today)
    # implement search function later, write conditions here - if params[:query] == ?? return ....
  end

  def search
    sql_query = " \
      evints.title @@ :query \
      OR evints.venue @@ :query \
      OR evints.category @@ :query \
      OR evints.description @@ :query \
    "
  Evint.where(sql_query, query: "%#{params[:query]}%")
  end

  def show
    @evint = Evint.find(params[:id])
  end

  private

  def evint_params
    params.require(:evint).permit(:title, :evint_link, :venue, :address, :lng, :lat, :category, :time, :description, :image_link, :date, :wechatid, :period)
  end
end
