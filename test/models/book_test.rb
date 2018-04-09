require "test_helper"

describe Book do
  describe "validations" do
    # all validations pass
    before do
      # Arrange
      # We need an author for a book, so add one to the
      # test DB. Use create! to fail fast - we aren't
      # interested in the author, but we need our
      # tests to be invalid if we can't have one
      author = Author.create!(name: "test author")
      @book = Book.new(title: "test book", author: author)
    end

    it "can be created will all required fields" do
      # Act
      result = @book.valid?

      # Assert
      result.must_equal true

      # Don't need to do this - we didn't write
      # the code that saves these values
      # @book.title.must_equal "test book"
    end

    # no title -> fail
    it "is invalid without a title" do
      @book.title = nil

      result = @book.valid?

      result.must_equal false
      @book.errors.messages.must_include :title
    end

    # duplicate title -> fail
    it "is invalid with a duplicate title" do
      title = "duplicate"
      Book.create!(title: title, author: Author.first)
      @book.title = title

      result = @book.valid?

      result.must_equal false
      @book.errors.messages.must_include :title
    end
  end

  describe "relations" do
    before do
      @book = Book.new(title: 'test book')
    end

    # author
    it "connects author and author_id" do
      # Arrange
      author = Author.create!

      # Act
      @book.author = author

      # Assert
      @book.author_id.must_equal author.id
    end

    # genres
    it "connects genres and genre_ids" do
      # Arrange
      genre = Genre.create!(name: "test genre")

      # Act
      @book.genres << genre

      # Assert
      @book.genre_ids.must_include genre.id
    end
  end
end
