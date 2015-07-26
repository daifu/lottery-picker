require 'spec_helper'

describe Predictors::Strategies::MostCommon do
  let(:data) {[["1", "2", "3", "4"], ["32", "42", "3", "3"], ["1", "2", "33", "4"]]}
  let(:least_commons) {Predictors::Strategies::LeastCommon.new(data)}

  it "should return least commons number" do
    Random.srand(993)
    least_commons.predict.should == ["4", "42", "2", "33"]
    Random.srand
  end
end