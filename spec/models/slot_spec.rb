require 'rails_helper'

RSpec.describe Slot, type: :model do
  context 'relation' do
    let(:pokemon) { FactoryBot.create(:pokemon) }
    let(:type) { FactoryBot.create(:type) }

    it 'persists relation between type and pokemon' do
      pokemon.slots.create(external_id: '3', type: type)
      slot = Slot.last
      expect(slot).to be_present
      expect(slot.type.id).to eq type.id
      expect(pokemon.id).to eq pokemon.id
    end
  end
end
