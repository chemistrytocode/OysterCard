require_relative 'station'
require_relative 'journeylog'

# Models a Oystercard
class Oystercard
  attr_reader :balance, :journeylog

  def initialize(journeylog = JourneyLog)
    @balance = 0
    @journeylog = journeylog.new
  end

  def top_up(money)
    raise 'You can only top up with a maximum of £90' if money > MAXIMUM_BALANCE

    raise 'Maximum balance exceeded' if money + balance > MAXIMUM_BALANCE

    @balance += money
  end

  def touch_in(entry_station)
    deduct if !@journeylog.journey.entry_station.nil?
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
