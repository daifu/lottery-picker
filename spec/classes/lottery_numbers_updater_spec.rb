require 'spec_helper'

describe LotteryNumbersUpdater do
  let(:file) {'files/power_ball.txt'}
  before do
    LotteryNumber::GAMES = {'powerball' => 2}
    Utils.should_receive(:download_game_file).with(2) {file}
  end

  it "should load lottery_numbers from a file" do
    LotteryNumbersUpdater.update_all
    LotteryNumber.count.should == 134
  end
end