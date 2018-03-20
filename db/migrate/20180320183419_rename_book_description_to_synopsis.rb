class RenameBookDescriptionToSynopsis < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :description, :synopsis
  end
end
