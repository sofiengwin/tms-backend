class PaymentStats < Service::Base
  DAILY_TOTAL_ADMIN = "SELECT DATE(created_at) as day, sum(amount) FROM payments GROUP BY day ORDER BY day DESC"
  DAILY_TOTAL_CASHIER = "SELECT DATE(created_at) as day, sum(amount) FROM payments WHERE cashier_id = ? GROUP BY day ORDER BY day DESC"
  MONTHLY_TOTAL_ADMIN = "SELECT to_char(created_at, 'Month') as month, sum(amount) FROM payments GROUP BY month ORDER BY month limit 1"
  MONTHLY_TOTAL_CASHIER = "SELECT to_char(created_at, 'Month') as month, sum(amount) FROM payments WHERE cashier_id = ? GROUP BY month ORDER BY month limit 1"
  YEARLY_TOTAL_ADMIN = "SELECT to_char(created_at, 'YYYY') as year, sum(amount) FROM payments GROUP BY year ORDER BY year limit 1"
  YEARLY_TOTAL_CASHIER = "SELECT to_char(created_at, 'YYYY') as year, sum(amount) FROM payments WHERE cashier_id = ? GROUP BY year ORDER BY year limit 1"

  attr_reader :cashier

  def initialize(cashier: nil)
    @cashier = cashier
  end

  def perform
    Service::Result.new.tap do |result|
      result.succeed({
        today: daily_totals&.first&.dig(:amount) || 0,
        daily_totals: daily_totals,
        monthly: monthly_total || 0,
        yearly: yearly_total || 0
      })
    end
  end

  def daily_totals
    @daily_totals ||= Payment.find_by_sql([
      cashier ? DAILY_TOTAL_CASHIER : DAILY_TOTAL_ADMIN,
      cashier&.id
    ]).map do |day|
      {date: day['day'], amount: day['sum']}
    end
  end

  def monthly_total
    Payment.find_by_sql([
      cashier ? MONTHLY_TOTAL_CASHIER : MONTHLY_TOTAL_ADMIN,
      cashier&.id
    ]).first&.attributes&.dig('sum')
  end

  def yearly_total
    Payment.find_by_sql([
      cashier ? YEARLY_TOTAL_CASHIER : YEARLY_TOTAL_ADMIN,
      cashier&.id
    ]).first&.attributes&.dig('sum')
  end
end