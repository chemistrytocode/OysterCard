require 'oystercard'

describe Oystercard do

  it {is_expected.to respond_to(:top_up).with(1).arguments}

  it 'Should top up oystercard with money' do
    expect{subject.top_up 90 }.to change {subject.balance}.by 90
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
