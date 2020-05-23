class CreateUser < Service::Create
  field :name, presence: true
  field :phone_number, presence: true
  field :mot_number, presence: true
  field :address, presence: true
  field :area_of_operation, presence: true
  field :hometown, presence: true
  field :state, presence: true

  def initialize(name:, phone_number:, mot_number:, address:, area_of_operation:, hometown:, state:, image: '')
    @name = name
    @phone_number = phone_number
    @mot_number = mot_number
    @address = address
    @area_of_operation = area_of_operation
    @hometown = hometown
    @state = state
  end

  def perform
    super(Driver)
  end
end

=begin
  add service helper classes
  add prmoise.rb
  add graphql rb
=end