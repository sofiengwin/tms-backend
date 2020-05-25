require 'test_helper'

class FetchDefaultersTest < ActiveSupport::TestCase
  test 'success' do
    admin = create(:admin)
    create(:payment, cashier: admin, driver: create(:driver, created_at: 4.days.ago), created_at: 1.day.ago)
    create(:payment, cashier: admin, driver: create(:driver, created_at: 3.days.ago, name: 'Boyle'), created_at: 2.day.ago)

    result = FetchDefaulters.perform()

    result.succeeded?
    assert result.value
  end
end