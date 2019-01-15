require 'oystercard'

describe Oystercard do

  let(:entry_station) {double "Old Street"}

  describe '#top up methods' do
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
    it 'Touching in updates  -in_journey variable - to true' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'Prevents you from travelling if balance is below £1' do
      message = "Insufficient funds"
      expect{subject.touch_in(entry_station)}. to raise_error message
    end
    it 'Should remember entry station, when touch_in' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch out methods' do
     it 'Touching out updates  -in_journey variable- to false' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
    it 'Should deduct the minimum fare on touching out' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect{subject.touch_out}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
    end
    it 'Should forget entry station on touch out and revenrt to nill' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end

  describe '#in journey? method' do
    it 'In journey? method returns true for in_journey variable' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'In journey? returns false for in_journey variable' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end


end
