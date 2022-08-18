require 'rails_helper'

RSpec.describe PokemonFetchService do
  include JsonHelper

  describe '.call' do
    let(:pokemon_response) { json_payload('pokemon_response') }

    let(:types_response) { json_payload('types_response') }

    let(:pokemons_response) { json_payload('pokemons_response') }

    before do
      stub_request(:get, 'https://pokeapi.co/api/v2/type').to_return(status: 200, body: types_response,
                                                                     headers: {})
      stub_request(:get, 'https://pokeapi.co/api/v2/pokemon').to_return(status: 200, body: pokemons_response,
                                                                        headers: {})
      stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1/').to_return(status: 200, body: pokemon_response,
                                                                           headers: {})
    end

    it 'populates pokemons, types and relation' do
      subject.call

      pokemon = Pokemon.last
      expect(pokemon.external_id).to eq '33'
      expect(pokemon.types.first.name).to eq 'matching_type'
    end
  end
end
