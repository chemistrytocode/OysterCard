require 'oystercard'

describe Oystercard do

  describe '#top up methods' do
    it {is_expected.to respond_to(:top_up).with(1).arguments}
    it 'Should top up oystercard with money' do
      expect{subject.top_up (Oystercard::MAXIMUM_BALANCE) }.to change {subject.balance}.by Oystercard::MAXIMUM_BALANCE
    end
    it 'Default card balance equals zero' do
      expect(subject.balance).to eq 0
    end
    it 'Will not allow you to top up more than £90 at once' do
      message = "You can only top up with a maximum of £90"
      expect{subject.top_up(100)}.to raise_error message
    end
    it 'Raises an error if max balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      message = "Maximum balance exceeded"
      expect{subject.top_up(50)}.to raise_error message
    end
  end
  
  describe '#touch_in methods' do
    it {is_expected.to respond_to(:touch_in)}
    it 'Touching in updates  -in_journey variable - to true' do
      subject.balance = Oystercard::MINIMUM_FARE
      subject.touch_in
      expect(subject.in_journey).to eq true
    end
    it 'Prevents you from travelling if balance is below £1' do
      message = "Insufficient funds"
      expect{subject.touch_in}. to raise_error message
    end
  end

  describe '#touch out methods' do
     it {is_expected.to respond_to(:touch_out)}
     it 'Touching out updates  -in_journey variable- to false' do
      subject.balance = Oystercard::MINIMUM_FARE
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
    it 'Should deduct the minimum fare on touching out' do
      subject.balance = Oystercard::MINIMUM_FARE
      subject.touch_in
      expect{subject.touch_out}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
    end
  end

  describe '#in journey? method' do
    it {is_expected.to respond_to(:in_journey?)}
    it 'In journey? method returns true for in_journey variable' do
      subject.balance = Oystercard::MINIMUM_FARE
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
    it 'In journey? returns false for in_journey variable' do
      subject.balance = Oystercard::MINIMUM_FARE
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end


end
