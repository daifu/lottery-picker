require 'spec_helper'

describe Predictors::Base do
  let(:predictor) { Predictors::Base.new(data) }

  let(:data) {[["1", "5"],["5","6"], ["6", "4"]]}
  let(:frequency_hash) { {"1" => 1, "5" => 2, "6" => 2, "4" => 1} }

  describe "#aggregate_data_with_frequency" do
    it "should get the correct out hash" do
      predictor.aggregate_data_with_frequency.should == frequency_hash
    end
  end

  describe '#predict' do
    before do
      Random.srand(993)
      predictor.should_receive(:use_sample).and_return(frequency_hash)
    end

    after do
      Random.srand
    end

    it 'should get the prediction' do
      predictor.predict.should == ["5", "1"]
    end
  end
end