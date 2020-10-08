require 'journey'
require 'oystercard'

describe Journey do
  #let(:station) { double('fake station', name: "High Barnet", zone: 1) }
  #let(:card) { card.new("High Barnet") }

  it "creates a new journey on touch in" do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in("High Barnet")
    expect(card.journey).to be_an_instance_of(Journey)
  end

  it "stores the entry station" do
    journey = Journey.new("High Barnet")
    expect(journey.entry_station).to eq("High Barnet")
  end

  it "stores the entry station" do
    journey = Journey.new("High Barnet")
    journey.touch_out("Colliers Wood")
    expect(journey.exit_station).to eq("Colliers Wood")
  end

  it "stores the whole journey" do
    journey = Journey.new("High Barnet")
    journey.touch_out("Colliers Wood")
    expect(journey.log).to eq({entry_station: "High Barnet", exit_station: "Colliers Wood"})
  end
end
