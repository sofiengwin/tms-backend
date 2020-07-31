class RecordPayment < Service::Create
  field :driver, presence: true
  field :cashier, presence: true
  field :amount, presence: true
  field :payment_type

  def initialize(driver:, cashier:, amount:, payment_type: 'Cash')
    @driver = driver
    @cashier = cashier
    @amount = payment_type == 'Cash' ? amount : 0;
    @payment_type = payment_type
  end

  def perform
    super(Payment)
  end
end