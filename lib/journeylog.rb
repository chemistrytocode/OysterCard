class JourneyLog
  attr_reader :journey, :journey_history
  def initialize
    @journey = Journey.new
    @journey_history = []
  end

  def start(station)
    @journey.start_journey(station)
  end

  def finish(station)
    @journey.end_journey(station)
  end

  def journeys
    @journey_history.clone
  end

  def add_to_history
    @journey_history << { Entry_Station: @journey.entry_station,
                          Exit_Station: @journey.exit_station }
  end

  def new_journey
    @journey = Journey.new
  end

end




# def initialize
#   @entry_station = nil
#   @exit_station = nil
# end
#
# def start_journey(entry_station)
#   @entry_station = entry_station
# end
#
# def end_journey(exit_station)
#   @exit_station = exit_station
# end
#
# def fare
#   return PENALTY_FARE if unsuccessful_journey?
#
#   MINIMUM_FARE
# end
