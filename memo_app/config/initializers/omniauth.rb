Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    # githubで設定したclient_idとclient_secretを渡す
    provider :github, "3dedabee17eb5c2c04e3", "79776ff2937d275763bdd6937509d552f5904e12"
  else
    # 平文で渡すのは危ないので暗号化、複合化
    provider :github,
             Rails.application.credentials.github[:client_id],
             Rails.application.credentials.github[:client_secret]
  end
end
