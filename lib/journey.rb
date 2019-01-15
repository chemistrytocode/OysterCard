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
    return PENALTY_FARE if entry_station == nil || exit_station == nil
    MINIMUM_FARE
    # if entry_station == nil || exit_station == nil
    #   PENALTY_FARE
    # else
    #   MINIMUM_FARE
    # end
  end

private
MINIMUM_FARE = 1
PENALTY_FARE = 6

end
#

#
#
#   def fare
#     1 or 6
#   end
#
#   @entry_station = nil
# end
#
# def in_journey?
#   !!entry_station
# end
#
# end

#Start journey
#Finish
#Calculate fare
#Whether complete?


# card = Oystercard.new
#       @journey
# card.top_up(5)
# card.touch_in(Station.new("WCG", 2))
#       @journey.start_journey(station)
# card.touch_out(Station.new("Kings Cross", 1)
#       @journey.end_journey(station)
#       @journey.fare/penalty
# card.deducts
# card.add_to_history
#
