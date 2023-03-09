class SessionsController < ApplicationController
  def create
    # userモデルから得たユーザ情報をセッションに格納
    # user情報を得るためにauthの情報をuserモデルに渡す
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    session[:user_id] = user.user_id
    redirect_to root_path, notice: 'サインインに成功しました'
  end
end
