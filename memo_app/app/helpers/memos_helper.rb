module MemosHelper
  def genre_collection_select(form)
    form.collection_select :genre_id, Genre.all, :id, :name, options = { include_blank: 'ジャンルを下記から選択 または ジャンルを指定しない', selected: @selected_genre_id }
  end
  def order_rule_options
    [
      ['作成日時が', 'created_at'],
      ['更新日時が', 'updated_at']
    ]
  end

  def order_time_options
    [
      ['新しい順に並び替える', 'desc'],
      ['古い順に並び替える', 'asc']
    ]
  end
end