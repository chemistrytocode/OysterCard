require 'journeylog'

describe JourneyLog do
  let(:entry) { double :station, name: 'Waterloo', zone: 1 }
  let(:exit) { double :station, name: 'Kings Cross', zone: 1 }

  describe '#start' do
    it 'Starts a new journey with an entry station' do
      subject.start(entry)
      expect(subject.journey.entry_station).to eq entry
    end
  end

  describe '#finish' do
    it 'Ends a journey with an entry station' do
      subject.finish(exit)
    expect(subject.journey.exit_station).to eq exit
    end
  end

  describe '#journeys' do
    it 'Returns a cloned array of all previous journeys' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#add_to_history' do
    it 'Adds journey details to journey_history' do
      subject.start(entry)
      subject.finish(exit)
      subject.add_to_history
      expect(subject.journey_history[0])
        .to eq ({ Entry_Station: entry, Exit_Station: exit })
    end
  end

  describe '#new_journey' do
    it 'Sets journey variablet to a new journey object' do
      subject.new_journey
      expect(subject.journey.entry_station).to eq nil
    end
  end
end
