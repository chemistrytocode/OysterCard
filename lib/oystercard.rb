require_relative 'station'
require_relative 'journeylog'

# Models a Oystercard
# Responsible for top_up, touch_in and touch_out.
class Oystercard
  attr_reader :balance, :journeylog

  def initialize(journeylog = JourneyLog)
    @balance = 0
    @journeylog = journeylog.new
  end

  def top_up(money)
    raise 'Maximum balance exceeded' if money + balance > MAXIMUM_BALANCE

    @balance += money
  end

  def touch_in(entry_station)
    deduct unless @journeylog.journey.entry_station.nil?
    raise 'Insufficient funds' if balance < MINIMUM_CHARGE

    @journeylog.start(entry_station)
  end

  def touch_out(exit_station)
    @journeylog.finish(exit_station)
    deduct
  end

  private

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def deduct(amount = @journeylog.price)
    @balance -= amount
    @journeylog.add_to_history
  end
end
