module SignInHelper
  
  def sign_in_github(user)
  # GitHubのモックデータを設定
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github, {
    provider: 'github',
    uid: user.uid, # ユーザーのuidを使用
    info: {
      nickname: user.name, # ユーザー名
      image: user.image_url # 画像URL
    }
  })

  #作成したデータをもとにサインインテスト
    visit root_url
    click_on 'GitHubでサインイン'
    @current_user = user
  end

  def sign_in_google_auth(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, {
      provider: 'google_oauth2',
      uid: user.uid, # ユーザーのuidを使用
      info: {
        name: user.name, # ユーザー名
        image: user.image_url # 画像URL
      }
    })

    #作成したデータをもとにサインインテスト
    visit root_url
    click_on 'Googleでサインイン'
    @current_user = user
  end

  def current_user
    @current_user
  end
end
