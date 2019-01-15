class Oystercard
attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil

  end

  def top_up(money)
    fail "You can only top up with a maximum of £90" if money > MAXIMUM_BALANCE
    fail "Maximum balance exceeded" if money + balance > MAXIMUM_BALANCE
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
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
