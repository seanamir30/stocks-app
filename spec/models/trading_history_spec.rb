require 'rails_helper'

RSpec.describe TradingHistory, type: :model do
  
  it "should belong to stock" do
    t = TradingHistory.reflect_on_association(:stock)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belong to user" do
    t = TradingHistory.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end

end
