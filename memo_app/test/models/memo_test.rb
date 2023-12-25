require "test_helper"
require 'faker'

class MemoTest < ActiveSupport::TestCase

   setup do
      @user = FactoryBot.create(:user)
      # タイトル
      @title_within_50 = Faker::Lorem.characters(number: 50)
      @title_over_50 = Faker::Lorem.characters(number: 51)

      #オリジナル
      @memo = FactoryBot.create(:memo, user: @user)
   end

   test 'タイトルが50字の場合登録できること' do
      @memo.update(title: @title_within_50)
      @memo.valid?
      assert_empty(@memo.errors[:title])
   end
   test 'タイトルが50字以上の場合エラーとなること' do
      @memo.update(title: @title_over_50)
      @memo.valid?
      assert_not_empty(@memo.errors[:title])
   end

   test 'メモが500字なら登録できること' do

   end
   test 'メモが500字以上の場合エラーとなること' do
      
   end
end
