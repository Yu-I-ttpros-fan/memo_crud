class DeleteColumnMemos < ActiveRecord::Migration[7.0]
  def change
    remove_column :memos, :registered_date, :datetime
  end
end
