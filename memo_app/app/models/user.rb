class User < ApplicationRecord
  has_many :created_memos, class_name: 'Memo'

  def self.find_or_create_from_auth_hash!(auth_hash)
    recieved_provider = auth_hash[:provider]
    recieved_uid = auth_hash[:uid]
    recieved_image_url = auth_hash[:info][:image]
    recieved_nickname = set_nickname(recieved_provider, auth_hash)

    # providerから渡されたuidが存在すればそのオブジェクトを返し、なければレコードを作って返す
    User.find_or_create_by!(provider: recieved_provider, uid: recieved_uid) do |user|
      user.name = recieved_nickname
      user.image_url = recieved_image_url
    end
  end

  def self.set_nickname(recieved_provider, auth_hash)
    if recieved_provider == 'github'
      auth_hash[:info][:nickname]
    elsif recieved_provider == 'google_oauth2'
      auth_hash[:info][:name]
    end
  end
end
