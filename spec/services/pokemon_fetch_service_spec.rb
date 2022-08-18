require 'rails_helper'

RSpec.describe PokemonFetchService do

  describe '.call' do
    let(:pokemon_response) {
      {
        id: 33,
        weight: 11,
        height: 22,
        types: [
          {
            slot: 1,
            type: {
              name: "matching_type",
              url: "https://pokeapi.co/api/v2/type/12/"
            },
          }
        ],
      }
    }

    let(:types_response) {
      {
        count: 20,
        next: nil,
        previous: nil,
        results: [
          {
            name: "matching_type",
            url: "https://pokeapi.co/api/v2/type/1/"
          },
        ]
      }
    }

    let(:pokemons_response) {
      {
        count: 1154,
        next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
        previous: nil,
        results: [
          {
            name: "bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/"
          },
        ]
      }
    }

    before do
      stub_request(:get, "https://pokeapi.co/api/v2/type").to_return(status: 200, body: types_response.to_json, headers: {})
      stub_request(:get, "https://pokeapi.co/api/v2/pokemon").to_return(status: 200, body: pokemons_response.to_json, headers: {})
      stub_request(:get, "https://pokeapi.co/api/v2/pokemon/1/").to_return(status: 200, body: pokemon_response.to_json, headers: {})
    end

    it 'populates pokemons, types and relation' do
      subject.call

      pokemon = Pokemon.last
      type = Type.last
      expect(pokemon.external_id).to eq '33'
      expect(pokemon.types.first.name).to eq 'matching_type'
    end
  end
end