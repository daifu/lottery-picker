require 'spec_helper'

describe Predictors::Strategies::MostCommon do
  let(:data) {[["1", "2", "3", "4"], ["32", "42", "3", "3"], ["1", "2", "33", "4"]]}
  let(:most_common) {Predictors::Strategies::MostCommon.new(data)}

  it "should return most common numbers" do
    Random.srand(993)
    most_common.predict.should == ["3", "2", "1", "4"]
    Random.srand
  end
end