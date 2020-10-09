require 'journey'
require 'oystercard'

describe Journey do
  let(:mock_entry) { double("fake entry station")}
  let(:mock_exit) { double("fake exit station")}
  let(:card) { Oystercard.new }
  subject(:journey) { Journey.new(mock_entry)}

  before do
    card.top_up(50)
  end

  it "is created on touch in" do
    expect(Journey).to receive(:new)
    card.touch_in(mock_entry)
  end

  it "stores the entry station" do
    expect(journey.entry_station).to eq(mock_entry)
  end

  it "stores the exit station" do
    journey.log_exit(mock_exit)
    expect(journey.exit_station).to eq(mock_exit)
  end

  it "stores the whole journey" do
    journey.log_exit(mock_exit)
    expect(journey.log).to eq({entry: mock_entry, exit: mock_exit})
  end
end
