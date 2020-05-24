require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test 'references' do
    payment = create(:payment, cashier_id: create(:admin).id, driver_id: create(:driver).id)

    assert payment.cashier
    assert payment.driver
  end
end
