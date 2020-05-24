class Payment < ApplicationRecord
  belongs_to :cashier, class_name: 'Admin'
  belongs_to :driver, class_name: 'Driver'
end
