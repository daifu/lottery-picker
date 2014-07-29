require 'spec_helper'

describe Predictors::Base do
  let(:predictor) {Predictors::Base.new}
  let(:data) {[6,4,7,2,1,9,8,0]}
  let(:n) {3}
  before { srand(2) } # Random can be deterministric
  it "should predict based on type and strategy" do
    predictor.random_select_top_n(data, n).should == [1, 2, 8]
  end

  describe "#get_count_hash" do
    let(:data) {[["1", "5"],["5","6"], ["6", "4"]]}

    it "should get the correct out hash" do
      predictor.get_count_hash(data).should == {"1" => 1, "5" => 2, "6" => 2, "4" => 1}
    end
  end
end