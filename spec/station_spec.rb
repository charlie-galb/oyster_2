require 'station'

describe Station do
  subject(:station) { Station.new("High Barnet", 5) }
  it "exists when created" do
    expect(station).to be_an_instance_of(Station)
  end
  it "has a name on initialize" do
    expect(station.name).to eq("High Barnet")
  end
  it "has a zone on initialize" do
    expect(station.zone).to eq(5)
  end
end
