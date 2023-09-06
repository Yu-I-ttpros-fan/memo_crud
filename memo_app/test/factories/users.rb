FactoryBot.define do
  factory :user do
    provider { "github" }
    sequence(:uid) { |i| "uid#{i}"}
    sequence(:name) { |i| "ユーザー#{i}"}
    sequence(:image_url) { |i| "http://exmample.com/image#{i}.jpg"}
  end
end
