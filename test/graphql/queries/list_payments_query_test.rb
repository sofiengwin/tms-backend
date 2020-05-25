require 'test_helper'

class ListPaymentsQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query listPayments {
      listPayments {
        amount
      }
    }
  GQL


  test 'success' do
    admin = create(:admin)
    create_list(:payment, 3, cashier: admin, driver: create(:driver))

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id) },
      params: {
        query: QUERY,
        variables: {}.to_json
      }
    )

    assert_json_data(
      'listPayments' => [
        { 'amount' => 1 },
        { 'amount' => 1 },
        { 'amount' => 1 },
      ]
    )
  end
end