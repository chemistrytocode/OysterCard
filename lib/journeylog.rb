require_relative 'journey'

# Models a JourneyLog class
# Monitors journey history and accesses journey methods
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

  def price
    @journey.fare
  end

  def journeys
    @journey_history.clone
  end

  def add_to_history
    @journey_history << { Entry_Station: @journey.entry_station,
                          Exit_Station: @journey.exit_station }
    new_journey
  end

  def new_journey
    @journey = Journey.new
  end
end
