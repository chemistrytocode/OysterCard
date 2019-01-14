require 'oystercard'

describe Oystercard do

  it 'Default card balance equals zero' do
    expect(subject.balance).to eq(0)
  end

end
