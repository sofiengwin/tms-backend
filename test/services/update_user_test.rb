require 'test_helper'

class UpdateUserTest < ActiveSupport::TestCase
  test 'success' do
    driver = create(:driver)
    
    result = UpdateUser.perform(driver, name: 'Updated Name')

    assert result.succeeded?
    assert result.value
    assert_equal 'Updated Name', result.value.name
  end

  test 'failure' do
    driver = create(:driver)
    
    result = UpdateUser.perform(driver, name: '', phone_number: '')
  
    assert result.failed?
    assert_errors [:blank], result.reason.details[:name]
    assert_errors [:blank], result.reason.details[:phone_number]
  end
end