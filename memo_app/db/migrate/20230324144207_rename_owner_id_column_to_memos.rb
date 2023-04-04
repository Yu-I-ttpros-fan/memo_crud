class RenameOwnerIdColumnToMemos < ActiveRecord::Migration[7.0]
  def change
    rename_column :memos, :owner_id, :user_id
  end
end
