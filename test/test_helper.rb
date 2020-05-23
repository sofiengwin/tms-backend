ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

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
end
