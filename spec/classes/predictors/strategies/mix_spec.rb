require 'spec_helper'

describe Predictors::Strategies::Mix do
  let(:data) {[["1", "2", "3", "4"], ["32", "42", "3", "3"], ["1", "2", "33", "4"]]}
  let(:mix) { Predictors::Strategies::Mix.new(data) }

  it "should return mixed data" do
    Random.srand(2)
    mix.predict.should == ["4", "3", "1", "32"]
    Random.srand
  end
end