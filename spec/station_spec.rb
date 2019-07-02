require 'station'

describe Station do

  it "should have a name" do
    station = Station.new('Aldgate East', 1)
    expect(station.name).to eq 'Aldgate East'
  end

  it "should have a zone" do
    station = Station.new('Aldgate East', 1)
    expect(station.zone).to eq 1
  end

end
