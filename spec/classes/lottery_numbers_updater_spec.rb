require 'spec_helper'

describe LotteryNumbersUpdater do
  let(:file) {'files/power_ball.txt'}
  before do
    LotteryNumber::GAMES = {'powerball' => 2}
    Utils.should_receive(:download_game_file).with('powerball') {file}
  end

  it "should load lottery_numbers from a file" do
    LotteryNumbersUpdater.update_all
    LotteryNumber.count.should == 134
    r = LotteryNumber.find_by_draw_id(134)
    r.numbers_string.should == "10|17|25|45|53|9"
  end
end