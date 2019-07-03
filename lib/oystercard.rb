require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  def initialize(balance = 0, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  attr_reader :balance

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station = '')
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    @journey_log.start(station)
  end

  def touch_out(station = '')
    @journey_log.finish(station)
    deduct(@journey_log.current_journey.fare)
    @journey_log.reset_current_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
