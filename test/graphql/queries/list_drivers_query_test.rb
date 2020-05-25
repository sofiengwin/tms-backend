require 'test_helper'

class ListDriversQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query listDrivers {
      listDrivers {
        name
      }
    }
  GQL


  test 'success' do
    create_list(:driver, 3)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(create(:admin).id) },
      params: {
        query: QUERY,
        variables: {}.to_json
      }
    )

    assert_json_data(
      'listDrivers' => [
        { 'name' => 'John' },
        { 'name' => 'John' },
        { 'name' => 'John' },
      ]
    )
  end
end