module Queries
  class Root < GraphQL::Schema::Object
    graphql_name 'Query'

    field :fetchDriver, resolver: FetchDriverQuery
    field :listDrivers, resolver: ListDriversQuery

    field :listPayments, resolver: ListPaymentsQuery
    field :fetchPayment, resolver: FetchPaymentQuery

    field :fetchDefaulters, resolver: FetchDefaultersQuery
  end
end