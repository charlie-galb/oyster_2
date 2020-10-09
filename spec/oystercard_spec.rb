require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }
  let(:mock_entry) { double("fake entry station")}
  let(:mock_exit) { double("fake exit station")}

  it 'initializes with a default balance of zero' do
    expect(card.balance).to be_zero
  end

  it 'initializes @journeys with an empty array' do
    expect(card.journeys).to be_empty
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
  end

  describe '#store_journey' do
    it 'stores the journey in @journeys' do
      card.top_up(10)
      card.touch_in(mock_entry)
      card.touch_out(mock_exit)
      expect(card.journeys).to include({entry: mock_entry, exit: mock_exit})
    end
  end

  it 'remembers multiple journeys' do
    card.top_up(10)

    2.times {
      card.touch_in(mock_entry)
      card.touch_out(mock_exit)
    }

    expect(card.journeys.count).to eq 2
    expect(card.journeys).to eq([{entry: mock_entry, exit: mock_exit}, {entry: mock_entry, exit: mock_exit}])
  end

end
