require "test_helper"

class GenreTest < ActiveSupport::TestCase
  test "指定されたジャンルが取得できること" do
    @genre = FactoryBot.create(:genre)
    assert_equal 'ジャンル1', @genre.name
  end
end
