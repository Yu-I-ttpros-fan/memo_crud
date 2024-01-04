require "test_helper"

class MemoDisplayTest < ActiveSupport::TestCase

   setup do
      @user = FactoryBot.create(:user)
      # ジャンル指定
      @genre1 = FactoryBot.create(:genre, name: "ジャンル1")
      @genre2 = FactoryBot.create(:genre, name: "ジャンル2")

      @memo1 = FactoryBot.create(:memo, user: @user, created_at: 3.days.ago, genre_id: @genre1.id)
      @memo2 = FactoryBot.create(:memo, user: @user, created_at: 2.days.ago, genre_id: @genre2.id)
      @memo3 = FactoryBot.create(:memo, user: @user, created_at: 1.day.ago)
   end
   
   test "デフォルトでは作成順・降順になること" do
      # 作成したメモがデフォルトで並んでるか確かめる
      memos = Memo.memo_display({}, @user)
      assert_equal [@memo3, @memo2, @memo1], memos
   end

   test "change_orderメソッドで昇順にメモが取得できること" do
      params = { order_rule: 'created_at', order_time: 'asc' }
      order_rule, order_time = Memo.change_order(params)
      assert_equal 'created_at', order_rule
      assert_equal 'asc', order_time
   end

   test "memo_displayメソッドで昇順にメモが取得できること" do
      params = { order_rule: 'created_at', order_time: 'asc' }
      memos = Memo.memo_display(params, @user)
      assert_equal [@memo1, @memo2, @memo3], memos
   end

   test "change_orderの更新順で並び替えられること" do
      params = { order_rule: 'updated_at', order_time: 'desc'}
      order_rule, order_time = Memo.change_order(params)
      assert_equal 'updated_at', order_rule
      assert_equal 'desc', order_time
   end

   test "memo_displayで更新順で並び替えられること" do
      params = { order_rule: 'updated_at', order_time: 'desc' }
      @memo1.update(content: '内容1-1')
      @memo3.update(content: '内容3-1')
      @memo2.update(content: '内容2-1')
      memos = Memo.memo_display(params, @user)
      assert_equal [@memo2, @memo3, @memo1], memos
   end

   test "ジャンルを指定できること" do
      @memo4 = FactoryBot.create(:memo, user: @user, genre_id: @genre1.id)

      #ジャンルを指定
      params_with_genre = { genre_id: @genre1.id }
      memos_with_genre = Memo.memo_display(params_with_genre, @user)
      assert_equal [@memo4,@memo1], memos_with_genre

      #ジャンルを設定しない
      params_without_genre = {}
      memos_no_set_genre = Memo.memo_display(params_without_genre, @user)
      assert_equal [@memo4,@memo3,@memo2,@memo1], memos_no_set_genre
      
   end
end
