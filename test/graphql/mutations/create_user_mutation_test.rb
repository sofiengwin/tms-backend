require 'test_helper'

class CreateUserMutationTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    mutation createUser($name: String!, $phoneNumber: String!, $motNumber: String!, $address: String!, $areaOfOperation: String!, $hometown: String!, $state: String!) {
      createUser(input: {name: $name, phoneNumber: $phoneNumber, motNumber: $motNumber, address: $address, areaOfOperation: $areaOfOperation, hometown: $hometown, state: $state}) {
        driver {
          name
          phoneNumber
          motNumber
          address
          areaOfOperation
          hometown
          state
        }
        errors {
          field
          code
        }
      }
    }
  GQL

  test 'success' do
    post(
      graphql_path,
      headers: {},
      params: {
        query: QUERY,
        variables: {
          name: 'Jake Peralta',
          phoneNumber: '08108',
          motNumber: '3910',
          address: 'Amazing Grace Estate',
          areaOfOperation: 'Ama',
          hometown: 'nfkslskdkdsklldks',
          state: 'kdkdf',
        }.to_json
      }
    )

    assert_json_data(
      'createUser' => {
        'driver' => {
          'name' => 'Jake Peralta',
          'phoneNumber' => '08108',
          'motNumber' => '3910',
          'address' => 'Amazing Grace Estate',
          'areaOfOperation' => 'Ama',
          'hometown' => 'nfkslskdkdsklldks',
          'state' => 'kdkdf',
        },
        'errors' => nil,
      }
    )
  end

  test 'failure' do
    post(
      graphql_path,
      headers: {},
      params: {
        query: QUERY,
        variables: {
          name: '',
          phoneNumber: '',
          motNumber: '',
          address: '',
          areaOfOperation: '',
          hometown: '',
          state: '',
        }.to_json
      }
    )

    assert_json_data(
      'createUser' => {
        'driver' => nil,
        'errors' => [
          { 'field' => 'name', 'code' => 'blank' },
          { 'field' => 'phone_number', 'code' => 'blank' },
          { 'field' => 'mot_number', 'code' => 'blank' },
          { 'field' => 'address', 'code' => 'blank' },
          { 'field' => 'area_of_operation', 'code' => 'blank' },
          { 'field' => 'hometown', 'code' => 'blank' },
          { 'field' => 'state', 'code' => 'blank' },
        ],
      }
    )
  end
end