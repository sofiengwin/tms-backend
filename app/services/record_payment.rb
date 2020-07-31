class RecordPayment < Service::Create
  field :driver, presence: true
  field :cashier, presence: true
  field :amount, presence: true
  field :payment_type
  field :resolved_at

  def initialize(driver:, cashier:, amount:, payment_type: 'Cash', resolved_at: Time.now)
    @driver = driver
    @cashier = cashier
    @amount = payment_type == 'Cash' ? amount : 0;
    @payment_type = payment_type
    @resolved_at = resolved_at
  end

  def perform
    super(Payment)
  end
end