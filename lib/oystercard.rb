require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  def initialize(balance = 0, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  attr_reader :balance, :journey_log

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

# oyster = Oystercard.new
# oyster.top_up(90)
# entry = Station.new('Aldgate',1)
# exit = Station.new('Acton',5)
# oyster.touch_in(entry)
# oyster.touch_out(exit)
# entry = Station.new('Shepherds Bush',2)
# exit = Station.new('Richmond',5)
# oyster.touch_in(entry)
# oyster.touch_out(exit)
# p oyster.journey_log
# p oyster.balance
