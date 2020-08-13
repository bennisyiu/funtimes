class Api::V1::LoginController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  URL = "https://api.weixin.qq.com/sns/jscode2session".freeze

  def wechat_user
    wechat_params = {
      appId: ENV["WECHAT_APP_ID"],
      secret: ENV["WECHAT_APP_SECRET"],
      js_code: params[:code],
      grant_type: "authorization_code"
    }

    @wechat_response ||= RestClient.get(URL, params: wechat_params)
    @wechat_user ||= JSON.parse(@wechat_response.body)
  end

  def login
    @user = User.find_or_create_by(open_id: wechat_user.fetch("openid"))
    render json: {
      userId: @user.id
    }
  end

  def update_user_info
    @user = User.find(params[:id])
    @user.update(name: params[:name], avatar: params[:avatar])
    render json: { status: :user_info_updated }
  end
end
