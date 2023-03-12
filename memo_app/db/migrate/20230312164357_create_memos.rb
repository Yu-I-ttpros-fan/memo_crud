class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.integer :owner_id
      t.integer :genre_id
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :registered_date, null: false

      t.timestamps
    end

    add_index :memos, %i[owner_id genre_id]
  end
end
