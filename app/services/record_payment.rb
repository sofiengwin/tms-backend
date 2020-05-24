class RecordPayment < Service::Create
  field :driver, presence: true
  field :cashier, presence: true
  field :amount, presence: true

  def initialize(driver:, cashier:, amount:)
    @driver = driver
    @cashier = cashier
    @amount = amount
  end

  def perform
    super(Payment)
  end
end