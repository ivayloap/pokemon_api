class SinglePokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :weight, :height, :external_id

  has_many :types
end
