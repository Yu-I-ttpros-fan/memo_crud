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

  test 'メモ登録ページ 記入して登録' do
    # github認証テストがあるためsetupメソッドを使わずに記載した
    user = FactoryBot.create(:user, :google_oauth2)
    sign_in_google_auth(user)

  visit new_memo_url
  assert_selector "h1", text: 'メモ登録ページ'

  fill_in "タイトル", with: "タイトル"
  fill_in "メモ", with: "メモテスト"

  click_on "メモを登録する"
  assert_selector "div.alert", text: "新規メモを登録しました"
  end


end
