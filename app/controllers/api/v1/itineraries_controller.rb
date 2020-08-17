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
    @evint_array = params[:evint_array]
    @evint_array.each do |id|
      evint = Evint.find(id)
      @activity = Activity.create!(evint: evint, itinerary: @itinerary)
    end
    render json: { status: "Itinerary created!" }
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    @remove_activities = params[:remove_activities] ## an array of act_id
    Activity.where(id: @remove_activities).destroy_all
    @evint_array = params[:evint_array]
    @evint_array.each do |id|
      evint = Evint.find(id)
      @activity = Activity.create!(evint: evint, itinerary: @itinerary)
    end

    # user find the itinerary that he/she wants to edit
    # front end - edit form
    # user chooses activity to remove (activity.destroy) ** an array of act_id -> destroy
    # user replaces it with another evint (as new activity) ** an array of evint_id --> create new acts
    # PUT request triggered when user taps "update" button
    #save
    # redirect (front end)
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    render json: { status: :itinerary_deleted }
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:user_id, :date, :name)
  end
end
