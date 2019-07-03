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

  it 'touching in changes journey to not false' do
    subject.top_up(50)
    subject.touch_in
    expect(subject.journey).not_to eq nil
  end

  it 'touching out changes journey to false' do
    subject.top_up(2)
    subject.touch_in
    subject.touch_out
    expect(subject.journey).to eq nil
  end

  it "checks for minimum balance on touch in and raises error if balance is < minimum fare: #{Oystercard::MINIMUM_FARE}" do
    expect { subject.touch_in }.to raise_error("Error: insufficient funds. Balance is #{subject.balance}.")
  end

  it "checks for minimum balance on touch in and does not raise error if balance is >= minimum fare: #{Oystercard::MINIMUM_FARE}" do
    subject.top_up(Oystercard::MINIMUM_FARE)
    expect { subject.touch_in }.not_to raise_error("Error: insufficient funds. Balance is #{subject.balance}.")
  end

  it 'deducts minimum fare from balance upon touch-out' do
    subject.top_up(2)
    subject.touch_in
    expect { subject.touch_out }.to change { subject.balance }.by(-Journey::MINIMUM_FARE)
  end

  it 'checks that the journey list is empty be default' do
    expect(subject.journey_list).to eq []
  end

  it 'touching in and out creates one journey' do
    subject.top_up(2)
    subject.touch_in('Aldgate East')
    subject.touch_out('Hammersmith')
    expect(subject.journey_list).not_to be_empty
  end
end
