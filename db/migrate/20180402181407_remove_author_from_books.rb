class RemoveAuthorFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :author
  end
end
