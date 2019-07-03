require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  def initialize(balance = 0)
    @balance = balance
    @journey = nil
    @journey_list = []
  end

  attr_reader :balance, :journey_list, :journey

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station = '')
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    @journey = Journey.new(station)
  end

  def touch_out(station = '')
    @journey_list << @journey.finish(station)
    deduct(@journey.fare)
    @journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
