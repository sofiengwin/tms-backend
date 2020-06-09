module Types
  class AdminType < BaseObject
    field :id, String, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :areaOfOperation, String, null: true
  end 
end