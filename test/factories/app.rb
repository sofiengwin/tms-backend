FactoryBot.define do
  factory :driver do
    name { "John" }
    phone_number  { "09002933" }
    mot_number { 'MOT' }
    address { 'Address' }
    area_of_operation { 'Area of Operation' }
    hometown { 'Amarata' }
    state { 'Bayelsa' }
  end

  factory :admin do
    name { "Charles Boyle" }
    email { "charles@example.com" }
    password { "test" }
  end
end