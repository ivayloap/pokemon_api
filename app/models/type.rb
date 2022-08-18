class Type < ApplicationRecord
  has_many :slots
  has_many :pokemons, through: :slots
end
