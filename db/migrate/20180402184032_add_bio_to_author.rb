class AddBioToAuthor < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :bio, :text
  end
end
