require 'test_helper'

class FetchDriverQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchDriver($driverId: ID!) {
      fetchDriver(driverId: $driverId) {
        name
        motNumber
        areaOfOperation
        payments {
          driver {
            name
            motNumber
          }
          cashier {
            name
          }
          amount
        }
      }
    }
  GQL

  test 'success' do
    driver = create(:driver)
    admin = create(:admin)
    create_list(:payment, 3, cashier: admin, driver: driver)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id)},
      params: {
        query: QUERY,
        variables: {
          driverId: driver.id,
        }.to_json
      }
    )

    assert_json_data(
      'fetchDriver' => {
        'name' => 'John',
        'motNumber' => 'MOT',
        'areaOfOperation' => 'Area of Operation',
        'payments' => [
          { 'driver' => { 'name' => 'John', 'motNumber' => 'MOT'}, 'cashier' => { 'name' => 'Charles Boyle'}, 'amount' => 1},
          { 'driver' => { 'name' => 'John', 'motNumber' => 'MOT'}, 'cashier' => { 'name' => 'Charles Boyle'}, 'amount' => 1},
          { 'driver' => { 'name' => 'John', 'motNumber' => 'MOT'}, 'cashier' => { 'name' => 'Charles Boyle'}, 'amount' => 1},
        ]
      }
    )
  end

  test 'driver not found' do
    driver = create(:driver)
    admin = create(:admin)
    create_list(:payment, 3, cashier: admin, driver: driver)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id)},
      params: {
        query: QUERY,
        variables: {
          driverId: 387933,
        }.to_json
      }
    )

    with_response_errors do |errors|
      assert 'notFound', errors[0]['extensions']['driver']
    end
  end

  test 'admin not logged in' do
    driver = create(:driver)
    admin = create(:admin)
    create_list(:payment, 3, cashier: admin, driver: driver)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(890000)},
      params: {
        query: QUERY,
        variables: {
          driverId: driver.id,
        }.to_json
      }
    )

    with_response_errors do |errors|
      assert_equal "notAuthorized", errors[0]['extensions']['admin']
    end
  end
end