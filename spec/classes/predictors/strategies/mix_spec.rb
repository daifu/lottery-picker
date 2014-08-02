require 'spec_helper'

describe Predictors::Strategies::Mix do
  let(:data) {[["1", "2", "3", "4"], ["32", "42", "3", "3"], ["1", "2", "33", "4"]]}
  let(:most_common) {Predictors::Strategies::Mix.new(data)}

  it "should return all" do
    most_common.run(10).should == ["3", "2", "1", "4", "32", "42", "33"]
  end

  context "return with random" do
    before {srand(2)}
    it "should choose randomly from first n numbers" do
      most_common.run(2).should == ["4", "32"]
    end
  end
end