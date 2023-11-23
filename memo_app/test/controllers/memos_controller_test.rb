require "test_helper"

class MemosControllerTest < ActionDispatch::IntegrationTest
   test "メモ一覧を表示する" do
      test_user = FactoryBot.create(:user, :google_oauth2)
      # ユーザ分、複数のメモを作成する
      FactoryBot.create_list(:memo, 3, user: test_user)

      sign_in_google_auth test_user
      assert_response :redirect
      get memos_url
      assert_select 'div.card.mb-2', count: 3
   end

   test "ほかのユーザのメモは表示されない" do
            test_user = FactoryBot.create(:user, :google_oauth2)
      # ユーザ分、複数のメモを作成する
      FactoryBot.create_list(:memo, 3, user: test_user)
      sign_in_user = FactoryBot.create(:user, :google_oauth2)

      sign_in_google_auth sign_in_user
      assert_response :redirect
      get memos_url
      assert_select 'div.card.mb-2', count: 0
   end

   test "他のプロバイダでログインしたメモは表示されない" do

   end

   test "自分が作成したメモを削除" do
     test_user = FactoryBot.create(:user, :google_oauth2 )
     memo = FactoryBot.create(:memo, user: test_user)

     sign_in_google_auth test_user
     assert_difference("Memo.count", -1) do
      delete memo_url(memo)
     end
   end

   test "他人のメモは削除できない" do
      memo_user = FactoryBot.create(:user)
      memo = FactoryBot.create(:memo, user: memo_user)
      sign_in_user = FactoryBot.create(:user)
 
      sign_in_github sign_in_user
      assert_difference("Memo.count", 0) do
       assert_raises(ActiveRecord::RecordNotFound) do
        delete memo_url(memo)
       end
      end
   end
end
