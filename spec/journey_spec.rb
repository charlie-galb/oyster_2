require 'journey'
require 'oystercard'

describe Journey do
  let(:station) { double :station, zone: 1 }
  let(:card) { double card: "High Barnet" }

  it "records if a journey is complete" do 
    card = Oystercard.new
    expect(card.journey).not_to be_completed
  end

  it "creates a new journey on touch in" do 
    card = Oystercard.new
    card.top_up(10)
    card.touch_in("High Barnet")
    expect(card.journey).to be_an_instance_of(Journey)
  end 

  it "creates a new journey on touch in" do 
    card = Oystercard.new
    card.top_up(10)
    card.touch_out("High Barnet")
    expect(card.journey).to be_an_instance_of(Journey)
  end 

  expect(journey.entry_station).to 

  # it "checks a new staion has been updated" do 
  #   expect(station.entry_station).to eq station
end 