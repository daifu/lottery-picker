require 'spec_helper'

describe Predictors::Strategies::MostCommon do
  let(:data) {[["1", "2", "3", "4"], ["32", "42", "3", "3"], ["1", "2", "33", "4"]]}
  let(:least_commons) {Predictors::Strategies::LeastCommon.new(data)}

  it "should return all" do
    least_commons.run(10).should == ["33", "42", "32", "4", "1", "2", "3"]
  end

  context "return with random" do
    before {srand(2)}
    it "should choose randomly from first n numbers" do
      least_commons.run(2).should == ["4", "1"]
    end
  end
end