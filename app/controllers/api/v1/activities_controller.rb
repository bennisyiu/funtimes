class Api::V1::ActivitiesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    if @itinerary.activities.count < 3
      @evint = Evint.find(params[:evint_id])
      @activity = Activity.new(activity_params)
      @activity.save
    else
      render json: { status: "failed", message: "You have already created 3 activities!" }, status: :unprocessable_entity
    end
    # first get itinerary by id
    # check, how mamy activities are in this itinerary
    # if it is less than 3, allow to create
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    render json: { status: :activity_deleted }
  end

  private

  def activity_params
    params.require(:activity).permit(:itinerary_id, :evint_id)
  end
end
