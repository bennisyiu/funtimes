class Api::V1::EvintsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

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
    "
    evints.where(sql_query, query: "%#{params[:query]}%")
  end

  def randomizer
    # user pick a date first
    # then pick preferred categories
    @evints = Evint.where(date: params[:date])
    evints_array = []
    @results = []
    @category_array = params[:category_array] # array of categories from front end
    @category_array.each do |category|
      evints = categorised(@evints, category) # all evints of the same cateory
      next if evints.blank?

      evints.each do |evint|
        evints_array << evint
      end
    end

    if evints_array.count > 3
      3.times do
        result = evints_array.sample
        evints_array = evints_array.reject { |x| x == result }
        @results << result
      end
    else
      @results = evints_array
    end
  end

  def categorised(evints, category)
    evints.where("category = ?", category)
  end

  def show
    @evint = Evint.find(params[:id])
  end

  private

  def evint_params
    params.require(:evint).permit(:title, :evint_link, :venue, :address, :lng, :lat, :category, :time, :description, :image_link, :date, :wechatid, :period)
  end
end
