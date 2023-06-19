module MemosHelper
  def genre_select(form, selected_genre_id)
    options = { include_blank: 'ジャンルを下記から選択 または ジャンルを指定しない' }
    html_options = { selected: selected_genre_id }

    form.collection_select :genre_id, Genre.all, :id, :name, options, html_options
  end
end
