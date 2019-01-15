require_relative 'oystercard'
require_relative 'station'

# Models a Journey
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
    return PENALTY_FARE if unsuccessful_journey?
    MINIMUM_FARE
  end

  def unsuccessful_journey?
    entry_station.nil? || exit_station.nil?
  end

  private

  MINIMUM_FARE = 1
  PENALTY_FARE = 6


end
