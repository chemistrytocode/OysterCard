require 'journey'

describe Journey do
  let(:start_station) { double(:station, :name => "WCG", :zone => 2)}
  let(:end_station) { double(:station, :name => "Kings Cross", :zone => 1)}

  describe '#new' do
    it 'Should initialize with entry_station as nil' do
      expect(subject.entry_station).to eq nil
    end
    it 'Should initialize with exit_station as nil' do
      expect(subject.exit_station).to eq nil
    end
  end

  describe '#start_journey' do
    it 'Should set entry_station to argument Station class' do
      subject.start_journey(start_station)
    end
  end

  describe '#end_journey' do
    it 'Should set end_station to argument Station class' do
      subject.end_journey(end_station)
    end
  end

  describe '#fare' do
    it 'Should return the minimum fare of 1 for a successful journey' do
      allow(subject).to receive(:successful_journey?) { true }
      expect(subject.fare).to eq 1
    end
    it 'Should return the penalty fare of 6 for a unsuccessful journey' do
      allow(subject).to receive(:successful_journey?) { false }
      expect(subject.fare).to eq 6
    end
  end


end
