require 'station'

describe Station do
  subject { described_class.new('Old Street', 1) }

  describe '#new' do
    it 'it is given a name' do
      expect(subject.name).to eq('Old Street')
    end
    it 'it is given a zone' do
      expect(subject.zone).to eq(1)
    end
  end
end
