Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    # YAMLファイルからクライアントIDとシークレットを読み込む
    credentials = YAML.safe_load(File.read("#{Rails.root}/config/credentials_local.yml"))[Rails.env]

    # GitHubのクライアントIDとシークレットを定数に代入
    GITHUB_CLIENT_ID = credentials['github']['client_id']
    GITHUB_CLIENT_SECRET = credentials['github']['client_secret']

    # GoogleのクライアントIDとシークレットを定数に代入
    GOOGLE_CLIENT_ID = credentials['google']['client_id']
    GOOGLE_CLIENT_SECRET = credentials['google']['client_secret']

    provider :github, GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET
    provider :google_auth2, GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET
  else
    # 平文で渡すのは危ないので暗号化、複合化
    provider :github,
             Rails.application.credentials.github[:client_id],
             Rails.application.credentials.github[:client_secret]
    provider :google_auth2,
              Rails.application.credentials.google[:client_id],
              Rails.application.credentials.google[:client_secret]
  end
end
