class Api::V1::ActivitiesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  # def update
  #   @activity = Activity.find(params[:id])
  #   @user_as_guest = User.find(params[:user_id])
  #   @guest = Guest.create(user: @user_as_guest, activity: @activity)
  #   render json: { status: :guest_created }
  # end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.guests.destroy_all
    @activity.destroy
    render json: { status: :activity_deleted }
  end
end
