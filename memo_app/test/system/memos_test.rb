require 'application_system_test_case'

class MemosTest < ApplicationSystemTestCase
  test 'メモ一覧ページを表示 githubログイン' do
    sign_in_github(FactoryBot.create(:user))
    visit memos_url

    assert_selector 'h1', text: 'メモ一覧'
  end

  test 'メモ一覧ページを表示 googleログイン' do
    # Googleログイン用のユーザーを作成するために:google_oauth2トレイトを適用
    user = FactoryBot.create(:user, :google_oauth2)
    sign_in_google_auth(user)
    visit memos_url

    assert_selector 'h1', text: 'メモ一覧'
  end
end
