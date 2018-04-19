require "test_helper"

describe SessionsController do
  describe 'auth_callback' do
    it 'creates a DB entry for a new user' do
      # Arrange
      user = User.new(
        provider: 'github',
        uid: 9999,
        email: 'test@test.org',
        name: 'test user'
      )
      user.must_be :valid?
      old_user_count = User.count

      # Act
      login(user)

      # Assert
      User.count.must_equal old_user_count + 1
      session[:user_id].must_equal User.last.id
    end

    it 'logs in an existing user' do
      # Arrange
      user = User.first
      old_user_count = User.count

      # Act
      login(user)

      # Assert
      User.count.must_equal old_user_count
      session[:user_id].must_equal user.id
    end

    it 'does not log in with insufficient data' do
      # Auth hash does not include a uid
    end

    it 'does not log in if the user data is invalid' do
      # Validation fails
    end

    # What about if the user is already logged in?
  end
end
