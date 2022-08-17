require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'persists data' do
    expect(FactoryBot.create(:type)).to be_persisted
  end
end
