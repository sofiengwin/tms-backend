require 'test_helper'

class PaymentStatsTest < ActiveSupport::TestCase
  test 'success' do
    admin = create(:admin)
    driver = create(:driver)
    2.times do |i|
      create_list(:payment, 2, created_at: i.days.ago, cashier: admin, driver: driver)
    end

    result = PaymentStats.perform(cashier: admin)
    pp result
    assert result.succeeded?
    assert result.value

    assert_equal 4, result.value[:yearly]
    assert_equal 4, result.value[:monthly]
    assert_equal 2, result.value[:today]
    assert_equal 2, result.value[:daily_totals].length
  end
end