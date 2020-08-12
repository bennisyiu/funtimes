class Api::V1::ActivitiesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    render json: { status: :activity_deleted }
  end

end
