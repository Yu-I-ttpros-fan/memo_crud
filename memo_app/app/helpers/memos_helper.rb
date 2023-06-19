module MemosHelper
  def genre_collection_select(form)
    form.collection_select :genre_id, Genre.all, :id, :name, options = { include_blank: 'ジャンルを下記から選択 または ジャンルを指定しない', selected: @selected_genre_id }
  end
end