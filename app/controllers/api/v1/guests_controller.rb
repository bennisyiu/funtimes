class Api::V1::GuestsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @activity = Activity.find(params[:activity_id])
    # which itinerary?
    # which activity to attend?
    # tap 'join' to show avatar, i.e. create a guest

  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    render json: { status: "Guest is not coming ..." }
  end
end
