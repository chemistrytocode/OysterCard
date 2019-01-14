class Oystercard
attr_accessor :balance, :touched

  def initialize

    @balance = 0
    @touched = false
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
    @touched = true
  end

def touch_out
  @touched = false
end

def in_journey?
  touched
end

private
MAXIMUM_BALANCE = 90

end
