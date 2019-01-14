class Oystercard
attr_accessor :balance

  def initialize

    @balance = 0

  end

  def top_up(money)
    total = @balance + money
  fail "You can only top up with a maximum of £90" if money > MAXIMUM_BALANCE
  fail "Topping up this amount will exceed your maximum balance of £90" if total > MAXIMUM_BALANCE
  @balance += money
  end

end
private

MAXIMUM_BALANCE = 90
