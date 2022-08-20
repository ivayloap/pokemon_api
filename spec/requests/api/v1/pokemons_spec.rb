require 'rails_helper'

RSpec.describe 'Api::V1::Pokemons', type: :request do
  describe 'GET /index' do
    let!(:pokemons) { FactoryBot.create_list(:pokemon, 2, :with_type) }
    let(:endpoint) { api_v1_pokemons_path }

    it 'returns paginated results' do
      get endpoint, params: { page: 1, per_page: 1 }
      first_page = JSON.parse(response.body)
      expect(first_page.first['id']).to eq Pokemon.first.id

      get endpoint, params: { page: 2, per_page: 1 }
      first_page = JSON.parse(response.body)
      expect(first_page.first['id']).to eq Pokemon.last.id
    end

    it 'returns related type, id and name of each pokemon' do
      get endpoint
      result = JSON.parse(response.body)
      expect(result.first['id']).to eq pokemons.first.id
      expect(result.first['name']).to eq pokemons.first.name
      expect(result.first['types'].first).to eq pokemons.first.types.first.attributes.slice('id', 'name', 'url')
    end
  end

  describe 'GET /show' do
    let(:pokemon) { FactoryBot.create(:pokemon, :with_type) }
    let(:endpoint) { api_v1_pokemon_path }
    it 'returns pokemon by id' do
      get endpoint, params: { id: pokemon.id }
      result = JSON.parse(response.body)
      matching_attributes = %w[id name weight height external_id]
      expect(result.slice(matching_attributes)).to eq pokemon.attributes.slice(matching_attributes)
    end

    context 'errors' do
      let(:wrong_id) { pokemon.id + 1 }
      let(:wrong_name) { "#{pokemon.name}a" }
      it 'returns error for non existing id' do
        get endpoint, params: { id: wrong_id }
        expect(JSON.parse(response.body)).to eq({ 'error' => PokemonNotFound.new('id' => wrong_id).message })
      end

      it 'returns error for non existing name' do
        get endpoint, params: { name: wrong_name }
        expect(JSON.parse(response.body)).to eq({ 'error' => PokemonNotFound.new('name' => wrong_name).message })
      end
    end
  end
end
