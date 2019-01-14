require 'oystercard'

describe Oystercard do
  describe '#top up methods' do
  it {is_expected.to respond_to(:top_up).with(1).arguments}

  it 'Should top up oystercard with money' do
    expect{subject.top_up (Oystercard::MAXIMUM_BALANCE) }.to change {subject.balance}.by 90
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

  describe '#deduct methods' do
    it {is_expected.to respond_to(:deduct).with(1).arguments}

    it "Should remove money spent, when there's enough money to spend" do
      subject.top_up(5)
      expect{subject.deduct 1}.to change{ subject.balance }.by -1
    end
  end

  describe '#touching methods' do

    it {is_expected.to respond_to(:touch_in)}

    it 'Touching in updates card touched variable to true' do
       subject.touch_in
       expect(subject.touched).to eq true
     end
     it {is_expected.to respond_to(:touch_out)}

     it 'Touching out updates card touched variable to false' do
       subject.touch_in
        subject.touch_out
        expect(subject.touched).to eq false
      end

      it {is_expected.to respond_to(:in_journey?)}

      it 'In journey? returns true when touched in' do
         subject.touch_in
         expect(subject.in_journey?).to eq true
       end

       it 'In journey? returns false when touched out' do
         subject.touch_in
          subject.touch_out
          expect(subject.in_journey?).to eq false
        end

end

end
