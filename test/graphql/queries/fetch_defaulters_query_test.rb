require 'test_helper'

class FetchDefaultersQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchDefaulters {
      fetchDefaulters {
        monday {
          name
        }
      }
    }
  GQL

  test 'success' do
    admin = create(:admin)
    create(:payment, cashier: admin, driver: create(:driver, created_at: 3.days.ago, name: 'Boyle'), created_at: 2.day.ago)

    post(
      graphql_path,
      headers: {
        'Authorization' => token_for_user(admin.id)
      },
      params: {
        query: QUERY,
      }
    )

    assert_json_data(
      'fetchDefaulters' => {
        'monday' => [
          { 'name' => 'Boyle' }
        ]
      }
    )
  end
end