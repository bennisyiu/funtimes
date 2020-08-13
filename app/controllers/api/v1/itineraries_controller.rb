class Api::V1::ItinerariesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  def index
    @user = User.find(params[:user_id])
    @itineraries = Itinerary.all
    # DESC order (show latest itineraries first)
    # implement search function later, write conditions here - if params[:query] == ?? return ....
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def create
    # it_params =  { user_id: itinerary_params[:user_id], date: itinerary_params[:date], name: itinerary_params[:name] }
    @itinerary = Itinerary.create(itinerary_params)
    # @activity1 = Activity.new(evint_id: itinerary_params[:evint_id1])
    # @activity1.itinerary = @itinerary
    # @activity1.save
    # @activity2 = Activity.new(evint_id: itinerary_params[:evint_id2])
    # @activity2.itinerary = @itinerary
    # @activity2.save
    # @activity3 = Activity.new(evint_id: itinerary_params[:evint_id3])
    # @activity3.itinerary = @itinerary
    # @activity3.save
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    # user find the itinerary he/she wants to edit
    # user chooses one of the 3 activities to remove from the itinerary
    # then replace it with a new activity
    # save
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    render json: { status: :itinerary_deleted }
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:user_id, :date, :name) #, :evint_id1, :evint_id2, :evint_id3)
  end
end
