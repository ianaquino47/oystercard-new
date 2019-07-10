require_relative 'station'

class Journey
  PENALTY_FARE = 8
  MINIMUM_FARE = 1
  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(station='')
    @exit_station = station
    self
  end

  def complete?
    @exit_station == nil ? false:true
  end

  def fare
    if self.complete?
      fare_amount(self.entry_station, self.exit_station)
    else
      PENALTY_FARE
    end
  end

  private

  def fare_amount(entry, exit)
    (entry.zone - exit.zone).abs + 1
  end
end

# entry_station = Station.new('Aldgate',1)
# exit_station = Station.new('Acton', 5)
# journey = Journey.new(entry_station)
# p journey.finish(exit_station)
# p journey.entry_station
# p journey.exit_station
# p journey.fare
