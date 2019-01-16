require 'journeylog'

describe JourneyLog do
  let(:entry_station) { double :station, name: "Waterloo", zone: 1 }
  let(:exit_station) { double :station, name: "Kings Cross", zone: 1 }
  let(:default_journey) { double :journey, entry_station: entry_station, exit_station: exit_station }

  describe '#start' do
    it 'Starts a new journey with an entry station' do
      subject.start(entry_station)
      expect(subject.journey.entry_station).to eq entry_station
    end
  end

  describe '#finish' do
    it 'Ends a journey with an entry station' do
    subject.finish(exit_station)
    expect(subject.journey.exit_station).to eq exit_station
    end
  end

  describe '#journeys' do
    it 'Returns a cloned array of all previous journeys' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#add_to_history' do
    it 'Adds journey details to journey_history' do
      subject.start(entry_station)
      subject.finish(exit_station)
      subject.add_to_history
      expect(subject.journey_history[0])
      .to eq ({Entry_Station: entry_station, Exit_Station: exit_station})
    end
  end

  describe '#new_journey' do
    it 'Sets journey variablet to a new journey object' do
      subject.new_journey
      expect(subject.journey.entry_station).to eq nil
    end
  end


end
