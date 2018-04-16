require "test_helper"

describe BooksController do
  describe 'index' do
    it 'sends a success response when there are many books' do
      # Assumptions
      Book.count.must_be :>, 0

      # Act
      get books_path

      # Assert
      must_respond_with :success
    end

    it 'sends a success response when there are no books' do
      # Arrange
      Book.destroy_all
      # Book.all.length.must_equal 0

      # Act
      get books_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'new' do
    it 'responds with success' do
      get new_book_path
      must_respond_with :success
    end

    # Don't need to test with no books,
    # because this action doesn't even
    # look at the database
  end

  describe 'create' do
    it 'can add a valid book' do
      # Arrange
      book_data = {
        title: 'controller test book',
        author_id: Author.first.id
      }
      old_book_count = Book.count

      # Assumptions
      Book.new(book_data).must_be :valid?

      # Act
      post books_path, params: { book: book_data }

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      Book.count.must_equal old_book_count + 1
      Book.last.title.must_equal book_data[:title]
    end

    it "won't add an invalid book" do
      # Arrange
      book_data = {
        author_id: Author.first.id
      }
      old_book_count = Book.count

      # Assumptions
      Book.new(book_data).wont_be :valid?

      # Act
      post books_path, params: { book: book_data }

      # Assert
      must_respond_with :bad_request
      Book.count.must_equal old_book_count
    end
  end

  describe 'show' do
    it 'sends success if the book exists' do
      get book_path(Book.first)
      must_respond_with :success
    end

    it 'sends not_found if the book D.N.E.' do
      # Get an invalid book ID somehow
      # more than one way to do this
      book_id = Book.last.id + 1

      get book_path(book_id)

      must_respond_with :not_found
    end
  end
end
