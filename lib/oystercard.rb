require_relative 'journey'
require_relative 'station'

class Oystercard
attr_reader :balance, :journey_history, :journey, :touched

  def initialize(journey = Journey)
    @balance = 0
    @journey_history = []
    @journey = journey.new
    @touched = false
  end

  def top_up(money)
    fail "You can only top up with a maximum of £90" if money > MAXIMUM_BALANCE
    fail "Maximum balance exceeded" if money + balance > MAXIMUM_BALANCE
    @balance += money
  end

  def touch_in(station)
    @journey.fare; deduct if touched
    @touched = true
    fail "Insufficient funds" if balance < MINIMUM_FARE
    @journey.start_journey(station)
  end

  def touch_out(station)
    @touched = false
    @journey.end_journey(station)
    deduct
    add_to_history
    @journey = Journey.new

  end

  def add_to_history
    @journey_history << { :Entry_Station => @journey.entry_station,
      :Exit_Station => @journey.exit_station }.clone
  end

private
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
  def deduct(amount = @journey.fare)
    @balance -= amount
  end
end
