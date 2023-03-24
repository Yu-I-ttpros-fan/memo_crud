class User < ApplicationRecord
  has_many :create_memos, class_name: 'Memo'
  def self.find_or_create_from_auth_hash!(auth_hash)
    recieved_provider = auth_hash[:provider]
    recieved_uid = auth_hash[:uid]
    recieved_nickname = auth_hash[:info][:nickname]
    recieved_image_url = auth_hash[:info][:image]

    # providerから渡されたuidが存在すればそのオブジェクトを返し、なければレコードを作って返す
    User.find_or_create_by!(provider: recieved_provider, uid: recieved_uid) do |user|
      user.name = recieved_nickname
      user.image_url = recieved_image_url
    end
  end
end
