# frozen_string_literal: true

require 'oystercard'
describe Oystercard do
  it 'initialises with a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'the balance can be topped up with top_up method' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it 'the maximum balance cannot exceed 90' do
    expect { subject.top_up(91) }.to raise_error("Error: Maximum balance is £#{Oystercard::MAXIMUM_BALANCE}")
  end

  #  it "the fare amount gets deducted from the total balance" do
  #    subject.top_up(50)
  #    expect(subject.deduct(3)).to eq 47
  #  end

  it { should_not be_in_journey } # used predicate method matcher

  it 'touching in changes in_journey to true' do
    subject.top_up(2)
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end

  it 'touching out changes in_journey to false' do
    subject.top_up(2)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end
  it "checks for minimum balance on touch in and raises error if balance is < minimum fare: #{Oystercard::MINIMUM_FARE}" do
    expect { subject.touch_in }.to raise_error("Error: insufficient funds. Balance is #{subject.balance}.")
  end
  it "checks for minimum balance on touch in and does not raise error if balance is >= minimum fare: #{Oystercard::MINIMUM_FARE}" do
    subject.top_up(Oystercard::MINIMUM_FARE)
    expect(subject.touch_in).to eq true
  end
  it 'deducts minimumfare from balance upon touch-out' do
    subject.top_up(2)
    subject.touch_in
    expect { subject.touch_out }.to change { subject.balance }.by(-1)
  end

  it 'card remembers entry station after touch in' do
    subject.top_up(2)
    station = double(:fakestation)
    allow(station).to receive(:name).and_return("Aldgate East")
    subject.touch_in(station.name)
    expect(subject.entry_station).to eq "Aldgate East"
  end

end
