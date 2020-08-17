class Api::V1::EvintsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  # def index ## used for both HOME and Add New Itinerary page
  #   if params[:query].present?
  #       @evints = search
  #   elsif params[:date].present? ## filter by date
  #     @evints = Evint.where(date: params[:date])
  #   else
  #     @evints = Evint.where("date >= ?", Date.today)
  #   end
  #   # since we have past events in the database, only display future events (from Date.today)
  #   # implement search function later, write conditions here - if params[:query] == ?? return ....
  # end

  def index
    @evints = Evint.where("date >= ?", Date.today)
    if params[:date].present? && params[:query].present?
      @evints = @evints.where(date: params[:date])
      @evints = search(@evints)
    elsif params[:date].present?
      @evints = @evints.where(date: params[:date])
    elsif params[:query].present?
      @evints = search(@evints)
    else
      @evints
    end
  end

  def search(evints)
    sql_query = " \
      evints.title @@ :query \
      OR evints.venue @@ :query \
      OR evints.category @@ :query \
      OR evints.description @@ :query \
    "
  evints.where(sql_query, query: "%#{params[:query]}%")
  end

  def show
    @evint = Evint.find(params[:id])
  end

  private

  def evint_params
    params.require(:evint).permit(:title, :evint_link, :venue, :address, :lng, :lat, :category, :time, :description, :image_link, :date, :wechatid, :period)
  end
end
