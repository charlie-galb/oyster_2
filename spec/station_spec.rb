require 'station'

describe Station do
  let(:card) { Oystercard.new }
  subject(:station) { Station.new("High Barnet", 5) }

  xit "is created when a person touches in" do
    card.top_up(10)
    card.touch_in("Colliers Wood")
    expect(Station).to receive(:new)
  end
  it "has a name on initialize" do
    expect(station.name).to eq("High Barnet")
  end
  it "has a zone on initialize" do
    expect(station.zone).to eq(5)
  end
end
