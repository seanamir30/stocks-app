require 'rails_helper'

RSpec.describe Stock, type: :model do
  
  it "should belong to user" do
    s = Stock.reflect_on_association(:user)
    expect(s.macro).to eq(:belongs_to)
  end

  it "should have many trading history" do
    should respond_to(:trading_history)
    s = Stock.reflect_on_association(:trading_history)
    expect(s.macro).to eq(:has_many)
  end

end
