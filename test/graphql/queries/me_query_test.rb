require 'test_helper'

class ListDriversQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query me {
      me {
        name
        email
      }
    }
  GQL


  test 'success' do
    admin = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id) },
      params: {
        query: QUERY,
        variables: {}.to_json
      }
    )

    assert_json_data(
      'me' => {
        'name' => admin.name,
        'email' => admin.email,
      }
    )
  end

  test 'failure' do
    admin = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(849494949404) },
      params: {
        query: QUERY,
        variables: {}.to_json
      }
    )

    with_response_errors do |errors|
      assert errors[0]['extensions']
    end
  end
end