require 'spec_helper'

describe LotteryNumber do
  it 'should raise exception if not found game type' do
    expect {LotteryNumber.get_numbers_string_by_type('error')}.should raise_error
  end

  context 'when db is populated' do
    let(:numbers_string) {"16|22|26|31|36|13"}
    before do
      LotteryNumber.create!(:game_id=>1, :numbers_string => numbers_string, :draw_date => Time.now)
    end
    it 'should return numbers_string from db' do
      LotteryNumber.get_numbers_string_by_type('superlotto-plus').should == [numbers_string]
    end
  end
end