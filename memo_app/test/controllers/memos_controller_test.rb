require "test_helper"

class MemosControllerTest < ActionDispatch::IntegrationTest
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
