module SignInHelper
  def sign_in_mock(user)
    # auth/provider/callbackにリダイレクトする用
    Omniauth.config.test_mode = true
    # auth/provider/callbackにリダイレクトされた際に渡されるデータを準備する
    Omniauth.config.add_mock(
      provider: user.provider.to_sym,
      uid: user.id,
      info: { name: user.name,
              image: user.image }
    )
  end

  def sign_in_github(user)
    sign_in_mock(user)
    visit root_url
    click_on 'GitHubでログイン'
    @current_user = user
  end

  def sign_in_google_auth(user)
    sign_in_mock(user)
    visit root_url
    click_on 'Googleでログイン'
    @current_user = user
  end

  def current_user
    @current_user
  end
end
