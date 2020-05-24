require 'test_helper'

class LoginMutationTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
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

  test 'success' do
    admin = create(:admin)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          email: admin.email,
          password: 'test'
        }.to_json,
      },
    )

    with_response_data do |json|
      assert json['login']['admin']
      assert json['login']['hhh']
    end
  end

  test 'failure' do
    admin = create(:admin)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          email: admin.email,
          password: 't'
        }.to_json,
      },
    )

    assert_json_data(
      'login' => {
        'admin' => nil,
        'hhh' => nil,
        'errors' => [
          { 'field' => 'emailOrPassword', 'code' => 'invalid' },
        ]
      }
    )
  end
end