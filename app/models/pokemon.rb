class Pokemon < ApplicationRecord
  has_many :slots
  has_many :types, through: :slots

  scope :by_id_or_name, ->(id, name) { where(id: id).or(where(name: name)) }
end
