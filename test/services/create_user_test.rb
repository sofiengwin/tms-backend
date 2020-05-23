require 'test_helper'

class CreateUserTest < ActiveSupport::TestCase
  test 'success' do
    result = CreateUser.perform(
      name: 'Sofien',
      phone_number: '09000',
      mot_number: '83933',
      address: 'ew9we0ew',
      area_of_operation: 'amarata',
      hometown: 'amarata',
      state: 'bayelsa',

    )
    
    assert result.succeeded?
    assert result.value
  end

  test 'failure' do
    result = CreateUser.perform(
      name: 'Sofien',
      phone_number: '09000',
      mot_number: '83933',
      address: 'ew9we0ew',
      area_of_operation: 'amarata',
      hometown: 'amarata',
      state: '',

    )

    assert result.failed?
    assert_errors [:blank], result.reason.details[:state]
  end
end