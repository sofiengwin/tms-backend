require 'test_helper'

class RecordPaymentTest < ActiveSupport::TestCase
  test 'success' do
    driver = create(:driver)
    cashier = create(:admin)

    result = RecordPayment.perform(
      driver: driver,
      cashier: cashier,
      amount: 200,
      resolved_at:  "2020-7-31T18:28"
    )

    assert result.succeeded?
    assert result.value
    assert result.value.driver
    assert result.value.cashier
    assert result.value.payment_type
    assert result.value.resolved_at
  end

  test 'failure' do
    result = RecordPayment.perform(
      driver: nil,
      cashier: nil,
      amount: nil,
    )

    assert result.failed?
    assert_errors [:blank], result.reason.details[:driver]
    assert_errors [:blank], result.reason.details[:amount]
    assert_errors [:blank], result.reason.details[:cashier]
  end
end