ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output

#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)


# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...

  def setup
    # Once you have enabled test mode, all requests
    # to OmniAuth will be short circuited to use the mock authentication hash.
    # A request to /auth/provider will redirect immediately to /auth/provider/callback.
    OmniAuth.config.test_mode = true
  end

  # Test helper method to generate a mock auth hash
  # from an instance of the User model
  # The structure should match what we get from GitHub
  def mock_auth_hash(user)
    return {
      provider: user.provider,
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name
      }
    }
  end

  def login(user)
    # Tell OmniAuth to use this user's info when it sees
    # an auth callback from github
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

    # Send a login request for that user
    # Note that we're using the named path for the callback, as defined
    # in the `as:` clause in `config/routes.rb`
    get auth_callback_path(:github)

    # In our books app, logging in should always redirect
    must_redirect_to root_path
  end
end
