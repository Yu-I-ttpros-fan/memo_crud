class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :signed_in?, :current_user

  private

  def signed_in?
    !!current_user
  end

  def current_user
    # user_idがセッションに格納されており、
    # @current_userに何も入ってなかったら@current_userに格納する
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    # サインインしていれば処理をやめ、していなければログインを促す
    return if signed_in?

    redirect_to root_path, alert: 'サインインしてください'
  end
end
