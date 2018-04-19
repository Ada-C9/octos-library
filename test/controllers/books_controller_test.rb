require "test_helper"

describe BooksController do
  # We split our controller tests in two: those that
  # have the user logged in, and those that do not.
  describe 'logged in user' do
    # We can keep all of our old tests, and add a login
    # step before to make them continue to work
    before do
      login(User.first)
    end
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

    describe 'edit' do
      it 'sends success if the book exists' do
        get edit_book_path(Book.first)
        must_respond_with :success
      end

      it 'sends not_found if the book D.N.E.' do
        # Get an invalid book ID somehow
        # more than one way to do this
        book_id = Book.last.id + 1

        get edit_book_path(book_id)

        must_respond_with :not_found
      end
    end

    describe 'update' do
      it 'updates an existing book with valid data' do
        # Arrange
        book = Book.first
        book_data = book.attributes
        book_data[:title] = "some updated title"

        # Assumptions
        book.assign_attributes(book_data)
        book.must_be :valid?

        # Act
        patch book_path(book), params: { book: book_data }

        # Assert
        must_redirect_to book_path(book)
        # Need to read the actual value from the
        # DB, not from our local variable
        # Book.first.title.must_equal book_data[:title]
        book.reload
        book.title.must_equal book_data[:title]
      end

      it 'sends bad_request for invalid data' do
        # Arrange
        book = Book.first
        book_data = book.attributes
        book_data[:title] = ""

        # Assumptions
        book.assign_attributes(book_data)
        book.wont_be :valid?

        # Act
        patch book_path(book), params: { book: book_data }

        # Assert
        must_respond_with :bad_request

        # Need to read the actual value from the
        # DB, not from our local variable
        # Book.first.title.must_equal book_data[:title]
        book.reload
        book.title.wont_equal book_data[:title]
      end

      it 'sends not_found for a book that D.N.E.' do
        book_id = Book.last.id + 1

        patch book_path(book_id)

        must_respond_with :not_found
      end
    end

    describe 'destroy' do
      it 'destroys a real book' do
        # Arrange
        book_id = Book.first.id
        old_book_count = Book.count

        # Act
        delete book_path(book_id)

        # Assert
        must_respond_with :redirect
        must_redirect_to books_path

        Book.count.must_equal old_book_count - 1
        Book.find_by(id: book_id).must_be_nil
      end

      it 'sends not_found when the book D.N.E' do
        book_id = Book.last.id + 1
        old_book_count = Book.count

        delete book_path(book_id)

        must_respond_with :not_found
        Book.count.must_equal old_book_count
      end
    end
  end

  describe 'guest user' do
    # For the guest user tests, we include one test for
    # each action that requires logging in, checking
    # that we got an error status code back

    # The rule we've implemented is that index and show
    # are fine for a guest user, but you must be logged in
    # to create, edit or destroy a book.
    it 'rejects requests for new book form' do
      get new_book_path
      must_respond_with :unauthorized
    end

    it 'rejects requests to create a book' do
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

      must_respond_with :unauthorized
      Book.count.must_equal old_book_count
    end

    it 'rejectes requests for the edit form' do
      get edit_book_path(Book.first)
      must_respond_with :unauthorized
    end

    it 'rejects requests to update a book' do
      # Arrange
      book = Book.first
      book_data = book.attributes
      book_data[:title] = "some updated title"

      # Assumptions
      book.assign_attributes(book_data)
      book.must_be :valid?

      # Act
      patch book_path(book), params: { book: book_data }

      must_respond_with :unauthorized
    end

    it 'rejects requests to destroy a book' do
      # Arrange
      book_id = Book.first.id
      old_book_count = Book.count

      # Act
      delete book_path(book_id)

      must_respond_with :unauthorized
      Book.count.must_equal old_book_count
    end
  end
end
