class RemoveTimestampsFromBooksGenres < ActiveRecord::Migration[5.1]
  def change
    remove_column :books_genres, :created_at
    remove_column :books_genres, :updated_at
  end
end
