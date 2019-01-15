class Oystercard
attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(money)
    fail "You can only top up with a maximum of £90" if money > MAXIMUM_BALANCE
    fail "Maximum balance exceeded" if money + balance > MAXIMUM_BALANCE
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_FARE
    @entry_station = station
    @exit_station = nil
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    add_to_history
  end

  def add_to_history
    @journey_history << { :Entry_Station => @entry_station, :Exit_Station => @exit_station }.clone
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

private
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1

def deduct(amount)
  @balance -= amount
end

end
