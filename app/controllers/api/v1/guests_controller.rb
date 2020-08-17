class Api::V1::GuestsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    render json: { status: "Guest is not coming ..." }
  end
end
