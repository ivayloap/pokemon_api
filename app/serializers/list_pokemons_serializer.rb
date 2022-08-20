class ListPokemonsSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :types
end
