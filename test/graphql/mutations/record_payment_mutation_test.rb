require 'test_helper'

class RecordPaymentMutation < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    mutation recordPayment($driverId: ID!, $cashierId: ID!, $amount: Int, $paymentType: String, $resolvedAt: String) {
      recordPayment(input: {driverId: $driverId, cashierId: $cashierId, amount: $amount, paymentType: $paymentType, resolvedAt: $resolvedAt}) {
        payment {
          driver {
            name
            motNumber
          }
          cashier {
            name
          }
          amount
          paymentType
        }
        errors {
          field
          code
        }
      }
    }
  GQL

  test 'success' do
    driver = create(:driver)
    cashier = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(cashier.id) },
      params: {
        query: QUERY,
        variables: {
          driverId: driver.id,
          cashierId: cashier.id,
          amount: 200,
          resolvedAt:  "2020-7-31T18:28",
        }.to_json
      }
    )

    assert_json_data(
      'recordPayment' => {
        'payment' => {
          'driver' => {
            'name' => 'John',
            'motNumber' => 'MOT',
          },
          'cashier' => {
            'name' => 'Charles Boyle'
          },
          'amount' => 200,
          'paymentType' => 'Cash',
        },
        'errors' => nil
      }
    )
  end

  test 'failure' do
    driver = create(:driver)
    cashier = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(cashier.id) },
      params: {
        query: QUERY,
        variables: {
          driverId: 356373839,
          cashierId: 37383393,
          amount: 200,
        }.to_json
      }
    )

    assert_json_data(
      'recordPayment' => {
        'payment' => nil,
        'errors' => [
          { 'field' => 'driverOrCashier', 'code' => 'blank' }
        ]
      }
    )
  end
end