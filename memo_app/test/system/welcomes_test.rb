require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
   test "トップページを表示" do
     visit root_url

     assert_selector "h1", text: "メモ登録アプリ"
   end
end
