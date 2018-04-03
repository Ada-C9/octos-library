class AddAuthorIdToBooks < ActiveRecord::Migration[5.1]
  def change
    # Create an author_id column on book, and set up a "foreign key" relation
    add_reference :books, :author, foreign_key: true
  end
end
