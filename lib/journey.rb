
class Journey
  PENALTY_FARE = 8
  MINIMUM_FARE = 1
  attr_reader :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    if self.complete?
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

  def finish(station='')
    @exit_station = station
    self
  end

  def complete?
    @exit_station == nil ? false:true
  end
end
