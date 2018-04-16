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
  end

  describe 'create' do
  end
end
