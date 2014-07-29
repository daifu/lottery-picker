require 'spec_helper'

describe Predictors::DataLoader do
  let(:loader) {Predictors::DataLoader.new('type')}
  let(:expected) {[["1", "2", "3", "4"], ["32", "42", "34", "3"]]}
  before do
    LotteryNumber.should_receive(:get_numbers_string_by_type).with('type') {["1|2|3|4", "32|42|34|3"]}
  end
  it "should return numbers array" do
    loader.fetch_data.should == expected
  end
end