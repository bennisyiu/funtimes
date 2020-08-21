class Api::V1::ItinerariesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.find(params[:user_id])
    @itineraries = @user.itineraries
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def create
    @itinerary = Itinerary.create!(itinerary_params)
    @user = User.find(params[:user_id])
    @guest = Guest.create!(user: @user, itinerary: @itinerary)
    @evint_array = params[:evint_array]
    @evint_array.each do |id|
      evint = Evint.find(id)
      @activity = Activity.create!(evint: evint, itinerary: @itinerary)
    end
    render json: { status: @itinerary }
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    @user_as_guest = User.find(params[:user_id])
    @guest = Guest.create!(user: @user_as_guest, itinerary: @itinerary)
    render json: { status: @itinerary }
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.activities.destroy_all
    @itinerary.guests.destroy_all
    @itinerary.destroy
    render json: { status: :itinerary_deleted }
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:user_id, :date, :name)
  end
end
