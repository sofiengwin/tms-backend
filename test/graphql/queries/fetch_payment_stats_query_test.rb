require 'test_helper'

class FetchPaymentStatsQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchPaymentStats($cashierId: ID) {
      fetchPaymentStats(cashierId: $cashierId) {
        yearlyTotal
        monthlyTotal
        today
        dailyTotals {
          amount
        }
        cashier {
          name
        }
      }
    }
  GQL

  test 'success' do
    admin = create(:admin)
    driver = create(:driver)
    2.times do |i|
      create_list(:payment, 2, created_at: i.days.ago, cashier: admin, driver: driver)
    end

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id)},
      params: {
        query: QUERY,
        variables: {
          cashierId: admin.id,
        }.to_json
      }
    )

    assert_json_data(
      'fetchPaymentStats' => {
        "yearlyTotal"=>4,
        "monthlyTotal"=>4,
        "today"=>2,
        "dailyTotals"=>[{"amount"=>2}, {"amount"=>2}],
        "cashier"=>{"name"=>"Charles Boyle"}
      }
    )
  end

  test 'app wide stats' do
    admin = create(:admin)
    driver = create(:driver)
    2.times do |i|
      create_list(:payment, 2, created_at: i.days.ago, cashier: admin, driver: driver)
    end

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id)},
      params: {
        query: QUERY,
        variables: {
          cashierId: nil,
        }.to_json
      }
    )

    assert_json_data(
      'fetchPaymentStats' => {
        "yearlyTotal"=>4,
        "monthlyTotal"=>4,
        "today"=>2,
        "dailyTotals"=>[{"amount"=>2}, {"amount"=>2}],
        "cashier"=>nil
      }
    )
  end
end