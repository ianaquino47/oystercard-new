require_relative 'journey'

class JourneyLog
  attr_reader :journey_class, :current_journey, :journey_list
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_list = []
    @current_journey = nil
  end

  def start(entry_station)
    journey_to_start = self.record_current_journey(entry_station)
    @journey_list << journey_to_start
  end

  def finish(exit_station)
    self.record_current_journey(nil) if @current_journey.nil?
    @current_journey.finish(exit_station)
    self.update_journey
  end

  def reset_current_journey
    @current_journey = nil
  end

  def update_journey
    @journey_list.pop
    @journey_list << @current_journey
  end

  def fare
    @journey_class.fare
  end

  # private

  def record_current_journey(entry_station)
    @current_journey||= @journey_class.new(entry_station)
  end

end

# entry_station1 = Station.new('Aldgate',1)
# exit_station1 = Station.new('Acton', 5)
#
# entry_station2 = Station.new('Liverpool street',1)
# exit_station2 = Station.new('Shepherds bush', 5)
# log = JourneyLog.new
# p log.start(entry_station1)
# p log.finish(exit_station1)
# # log.reset_current_journey
# p log.start(entry_station2)
# p log.finish(exit_station2)
