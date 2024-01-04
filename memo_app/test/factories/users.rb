FactoryBot.define do
  factory :user do
    # githubの場合のデータ
    provider { "github" }
    sequence(:uid) { |i| "github_uid#{i}"}
    sequence(:name) { |i| "githubユーザー#{i}"}
    sequence(:image_url) { |i| "http://exmample.com/githubimage#{i}.jpg"}

    # providerが"google_auth2"の場合のデータ
    trait :google_oauth2 do
      provider { "google_oauth2" }
        sequence(:uid) { |i| "google_uid#{i}" }
        sequence(:name) { |i| "Googleユーザ#{i}" }
        sequence(:image_url) { |i| "http://example.com/google_image#{i}.jpg" }
    end
  end
end
