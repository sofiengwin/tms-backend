require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query listPayments {
      listPayments {
        amount
      }
    }
  GQL

LOGIN = <<-GQL
  mutation login($email: String!, $password: String!) {
    login(input: {email: $email, password: $password}) {
      admin {
        name
        email
      }
      hhh
      errors {
        field
        code
      }
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

  test 'login' do
    admin = create(:admin)

    post(
      graphql_path,
      headers: { 'Authorization' => "#{token_for_user(admin.id)}.fake.not.working"},
      params: {
        query: LOGIN,
        variables: {
          email: admin.email,
          password: 'test',
          kdkd: 'djkkds'
        }.to_json
      }
    )

    assert_equal 200, response.status
    pp response.body
  end
end