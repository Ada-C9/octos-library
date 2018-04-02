class PublicationYearNotDate < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :publication_date
    add_column :books, :publication_year, :integer
  end
end
