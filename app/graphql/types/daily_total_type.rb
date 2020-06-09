module Types
  class DailyTotalType < BaseObject
    field :date, String, null: false
    field :amount, Integer, null: false
  end
end