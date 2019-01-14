class Oystercard
attr_accessor :balance

  def initialize

    @balance = 0

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


private
MAXIMUM_BALANCE = 90

end
