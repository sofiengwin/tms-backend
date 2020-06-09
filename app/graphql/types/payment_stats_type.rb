module Types
  class PaymentStatsType < BaseObject
    field :yearlyTotal, Integer, null: false, hash_key: :yearly
    field :monthlyTotal, Integer, null: false, hash_key: :monthly
    field :today, Integer, null: false, hash_key: :today
    field :dailyTotals, [DailyTotalType], null: true, hash_key: :daily_totals
    field :cashier, AdminType, null: true, hash_key: :cashier
  end
end