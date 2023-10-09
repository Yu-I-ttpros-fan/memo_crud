FactoryBot.define do
  factory :memo do
    association :user, factory: :user # ファクトリーを指定して関連付け
    sequence(:title) { |i| "タイトル#{i}" }
    sequence(:content) { |i| "内容#{i}" }

    trait :google_oauth2 do
      association :user, factory: [:user, :google_oauth2]
      sequence(:title) { |i| "タイトル#{i}" }
      sequence(:content) { |i| "内容#{i}" }
    end
  end
end
