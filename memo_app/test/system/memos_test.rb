require "application_system_test_case"

class MemosTest < ApplicationSystemTestCase
  test "メモ一覧ページを表示" do
    visit memos_url
  
     assert_selector "h1", text: "メモ一覧"
   end
end
