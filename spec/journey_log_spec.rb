require 'journey_log'

describe JourneyLog do
  let(:fake_journey_class) {double :fake_journey_class}
  let(:fake_station) {double :fake_station}
  let(:fake_journey) {double :fake_journey}
  subject {described_class.new(fake_journey_class)}

  it "initialises with a journey class parameter" do
    expect(subject.journey_class).to eq fake_journey_class
  end

  it "starts a new journey with an entry station" do
    expect(fake_journey_class).to receive(:new).with(fake_station)
    subject.start(fake_station)
  end

  it 'records a journey' do
    allow(fake_journey_class).to receive(:new).and_return fake_journey
    subject.start(fake_station)
    expect(subject.journey_list).to include fake_journey
  end

  it 'records a journey even if no touch in' do
    allow(fake_journey_class).to receive(:new).and_return fake_journey
    allow(fake_journey).to receive(:finish).and_return fake_journey
    subject.finish(fake_station)

    expect(subject.journey_list).to include fake_journey
  end

end
