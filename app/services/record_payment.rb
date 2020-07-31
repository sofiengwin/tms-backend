class RecordPayment < Service::Create
  field :driver, presence: true
  field :cashier, presence: true
  field :amount, presence: true
  field :type

  def initialize(driver:, cashier:, amount:, type: 'cash')
    @driver = driver
    @cashier = cashier
    @amount = type == 'cash' ? amount : 0;
    @type = type
  end

  def perform
    super(Payment)
  end
end