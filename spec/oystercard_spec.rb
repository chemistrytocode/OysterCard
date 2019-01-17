require 'oystercard'

describe Oystercard do
  let(:start_station) { double(:station, name: 'WCG', zone: 2) }
  let(:end_station) { double(:station, name: 'Kings Cross', zone: 1) }

  describe '#new' do
    it 'Should initialize balance as 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top up methods' do
    it 'Should top up oystercard with money' do
      expect(subject.top_up(Oystercard::MAXIMUM_BALANCE))
        .to eq Oystercard::MAXIMUM_BALANCE
    end
    it 'Raises an error if max balance is exceeded' do
      subject.top_up Oystercard::MAXIMUM_BALANCE
      message = 'Maximum balance exceeded'
      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe '#touch_in methods' do
    it 'Deduct by penalty on unsuccessful journey: touch_in w/o touch_out' do
      subject.top_up(10)
      2.times { subject.touch_in(start_station) }
      expect(subject.balance).to eq 4
    end
    it 'Prevents you from travelling if balance is below minimum charge' do
      message = 'Insufficient funds'
      expect { subject.touch_in(start_station) }. to raise_error message
    end
    it 'Sets journey entry_station of journey_log to start_station' do
      subject.top_up(10)
      subject.touch_in(start_station)
      expect(subject.journeylog.journey.entry_station).to eq start_station
    end
  end

  describe '#touch out methods' do
    it 'Deduct by minimum fare on successful journey' do
      subject.top_up(10)
      subject.touch_in(start_station)
      expect { subject.touch_out(end_station) }.to change { subject.balance }
        .by -Journey::MINIMUM_FARE
    end
    it 'Deduct by penalty on unsuccessful journey: touch_out w/o touch_in' do
      subject.top_up(10)
      expect { subject.touch_out(end_station) }.to change { subject.balance }
        .by -Journey::PENALTY_FARE
    end
  end
end
