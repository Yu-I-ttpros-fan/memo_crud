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
  case 
  when respond_to?(:visit)
    visit root_url
    click_on 'GitHubでサインイン'
  when respond_to?(:get)
    get '/auth/github/callback'
  else
    raise NotImplementedError.new
  end
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
    case 
    when respond_to?(:visit)
      visit root_url
      click_on 'Googleでサインイン'
    when respond_to?(:get)
      get '/auth/google_oauth2/callback'
    else
      raise NotImplementedError.new
    end
    @current_user = user
  end

  def current_user
    @current_user
  end

  class ActionDispatch::IntegrationTest
    include SignInHelper
  end
end
