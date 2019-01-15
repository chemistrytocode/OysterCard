require_relative 'oystercard'
require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    # MINIMUM_FARE if successful_journey?
    # PENALTY_FARE
    if successful_journey?
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end


private
MINIMUM_FARE = 1
PENALTY_FARE = 6
  def successful_journey?
    false if entry_station == nil || exit_station == nil
    true
  end

end
