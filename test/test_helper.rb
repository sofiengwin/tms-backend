ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.library :active_record
    end
  end

  # Add more helper methods to be used by all tests here...
  def assert_errors(expected, details)
    assert_equal expected, details.map { |h| h[:error] }
  end

  def assert_json_data(expected)
    with_response_data do |json|
      assert_equal expected, json, response.body
    end
  end

  def with_response_data
    yield JSON.parse(response.body)['data']
  end

  def with_response_errors
    yield JSON.parse(response.body)['errors']
  end

  def token_for_user(user_id)
    ActionToken.encode(user_id, scope: 'login')
  end
end
