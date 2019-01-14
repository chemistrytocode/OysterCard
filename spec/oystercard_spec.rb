require 'oystercard'

describe Oystercard do

  it {is_expected.to respond_to(:top_up).with(1).arguments}

  it 'Should top up oystercard with money' do
    expect{subject.top_up 400 }.to change {subject.balance}.by 400
  end

  it 'Default card balance equals zero' do
    expect(subject.balance).to eq 0

  end


end
