require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query listPayments {
      listPayments {
        amount
      }
    }
  GQL

  test 'with valid token' do
    admin = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(admin.id)},
      params: {
        query: QUERY,
      }
    )

    assert_equal 200, response.status
  end

  test 'with invalid token' do
    admin = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => "#{token_for_user(admin.id)}.fake.not.working"},
      params: {
        query: QUERY,
      }
    )

    assert_equal 401, response.status
  end
end