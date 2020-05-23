class UpdateUser < Service::Update
  field :name, presence: true
  field :phone_number, presence: true

  def initialize(driver, name: NOT_SET, phone_number: NOT_SET)
    @driver = driver
    @name = name
    @phone_number = phone_number
  end

  def perform
    super(@driver)
  end
end