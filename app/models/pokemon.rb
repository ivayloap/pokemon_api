class Pokemon < ApplicationRecord
  has_many :slots
  has_many :types, through: :slots
end
