require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it 'persists data' do
    expect(FactoryBot.create(:pokemon)).to be_persisted
  end
end
