class Api::V1::ActivitiesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def update
  # Tap 'I'm in'/Yes, triggers a PUT request
  # create a Guest object
    @activity = Activity.find(params[:id])
    @user_as_guest = User.find(params[:user_id])
    @guest = Guest.create(user: @user_as_guest, activity: @activity)
    render json: { status: :guest_created }
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    render json: { status: :activity_deleted }
  end

end
