require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }
  let(:mock_entry) { double("fake entry station")}
  let(:mock_exit) { double("fake exit station")}

  it 'initializes with a default balance of zero' do
    expect(card.balance).to be_zero
  end

  it 'initializes @journeys with an empty array' do
    expect(card.all_journeys).to be_empty
  end

  it 'can have money added to it' do
    card.top_up(5)
    expect(card.balance).to eq 5
  end

  it 'raises error if cash input surpasses default max' do
    default_max = Oystercard::DEFAULT_MAX
    card.top_up(default_max)
    expect { card.top_up 1 }.to raise_error "Max balance of #{default_max} is exceeded"
  end

  describe '#touch_in' do
    it 'changes the @status of the Oystercard to true' do
      card.top_up(5)
      card.touch_in(mock_entry)
      expect(card.in_journey?).to be true
    end

    it 'throws an error if user tries to #touch_in with insufficient funds' do
      expect{ card.touch_in(mock_entry) }.to raise_error "INSUFFICIENT FUNDS"
    end
  end

  describe '#touch_out' do
    it 'changes the @status of the Oystercard to false' do
      card.top_up(5)
      card.touch_in(mock_entry)
      card.touch_out(mock_exit)
      expect(card.in_journey?).to be false
    end

    it 'deducts minimum fare from balance' do
      card.top_up(5)
      card.touch_in(mock_entry)
      expect { card.touch_out(mock_exit) }.to change {card.balance}.by -1
    end
    it 'deducts penalty fare from balance' do
      card.top_up(10)
      expect { card.touch_out(mock_exit) }.to change {card.balance}.by -6
    end
  end

  describe '#store_journey' do
    it 'stores the journey in @all_journeys' do
      card.top_up(10)
      card.touch_in(mock_entry)
      card.touch_out(mock_exit)
      expect(card.all_journeys).to include({entry: mock_entry, exit: mock_exit})
    end

    it 'remembers multiple journeys' do
      card.top_up(10)

      2.times {
        card.touch_in(mock_entry)
        card.touch_out(mock_exit)
      }

      expect(card.all_journeys.count).to eq 2
      expect(card.all_journeys).to eq([{entry: mock_entry, exit: mock_exit}, {entry: mock_entry, exit: mock_exit}])
    end
  end

  describe "#fare" do

    let(:mock_journey) { double('fake journey', nil?: false) }

    before do
      card.top_up(20)
    end

    it 'returns the minimum fare if users behave correctly' do
      allow(Journey).to receive(:new).and_return(mock_journey)
      allow(mock_journey).to receive(:log_exit)
      allow(mock_journey).to receive(:log).and_return({entry: mock_entry, exit: mock_exit})
      card.touch_in(mock_entry)
      card.touch_out(mock_exit)
      expect(card.fare).to eq(1)
    end
    it 'returns the penalty fare if a user forgets to #touch_in' do
      card.touch_out("East Finchley")
      expect(card.fare).to eq(6)
    end
    it 'returns the penalty fare if a user forgets to #touch_out' do
      allow(Journey).to receive(:new).and_return(mock_journey)
      allow(mock_journey).to receive(:log).and_return({entry: mock_entry})
      card.touch_in("East Finchley")
      expect(card.fare).to eq(6)
    end
  end
end
