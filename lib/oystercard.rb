class Oystercard
attr_accessor :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    fail "You can only top up with a maximum of £90" if money > MAXIMUM_BALANCE
    fail "Maximum balance exceeded" if money + balance > MAXIMUM_BALANCE
    @balance += money
  end

  def deduct(money)
    @balance -= money
    "You have £#{@balance} left"
  end

  def touch_in
    fail "Insufficient funds" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    in_journey
  end

private
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

end
