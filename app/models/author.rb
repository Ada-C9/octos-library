class Author < ApplicationRecord
  has_many :books # plural


  def first_published
    my_books = self.books.where.not(publication_year: nil)
    my_books = my_books.order(publication_year: :asc)

    if my_books.length == 0
      return nil
    end

    first_book = my_books.first

    return first_book.publication_year
  end
end
