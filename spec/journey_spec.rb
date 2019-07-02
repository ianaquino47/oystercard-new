require 'journey'

describe Journey do
  it "should record a start station when touched in" do
    station = double (:fake_journey)
    allow(station).to receive(:name).and_return('Aldgate East')
    journey = Journey.new(station)
    expect(journey.entry_station).to eq 'Aldgate East'
  end


end
