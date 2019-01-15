require 'oystercard'

describe Oystercard do
  let(:start_station) { double(:station, name: 'WCG', zone: 2) }
  let(:end_station) { double(:station, name: 'Kings Cross', zone: 1) }

  describe '#new' do
    it 'Should initialize balance as 0' do
      expect(subject.balance).to eq 0
    end
    it 'Should initialize journey_history as an empty array' do
      expect(subject.journey_history).to be_empty
    end
    it 'Should initialize journey as a new Journey object' do
      expect(subject.journey).to be_a Journey
    end
    it 'Should initialize touched as false' do
      expect(subject.touched).to eq false
    end
  end

  describe '#top up methods' do
    it 'Should top up oystercard with money' do
      expect { subject.top_up Oystercard::MAXIMUM_BALANCE }
        .to change { subject.balance }.by Oystercard::MAXIMUM_BALANCE
    end
    it 'Will not allow you to top up more than £90 at once' do
      message = 'You can only top up with a maximum of £90'
      expect { subject.top_up(100) }.to raise_error message
    end
    it 'Raises an error if max balance is exceeded' do
      subject.top_up Oystercard::MAXIMUM_BALANCE
      message = 'Maximum balance exceeded'
      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe '#touch_in methods' do
    # it 'Should deduct balance by the PENALTY_FARE if customer
    # touchs in without touching out' do
    #   subject.top_up(10)
    #   2.times { subject.touch_in(start_station) }
    #   expect(subject.balance).to eq 4
    # end
    it 'Sets touched to true on touch_in' do
      subject.top_up(10)
      subject.touch_in(start_station)
      expect(subject.touched).to eq true
    end
    it 'Prevents you from travelling if balance is below £1' do
      message = 'Insufficient funds'
      expect { subject.touch_in(start_station) }. to raise_error message
    end
  end

  describe '#touch out methods' do
    it 'Should deduct the minimum fare on touching out' do
      subject.top_up(10)
      subject.touch_in(start_station)
      expect { subject.touch_out(end_station) }.to change { subject.balance }
        .by -Oystercard::MINIMUM_CHARGE
    end
    it 'Sets touched to false on touch_out' do
      subject.top_up(10)
      subject.touch_in(start_station)
      subject.touch_out(end_station)
      expect(subject.touched).to eq false
    end
  end

  describe '#add_to_history' do
    it 'Confirms entry station was saved in jouney_history' do
      subject.top_up(Oystercard::MINIMUM_CHARGE)
      subject.touch_in(start_station)
      subject.touch_out(end_station)
      subject.add_to_history
      expect(subject.journey_history[0][:Exit_Station]).to eq end_station
    end
  end
end
