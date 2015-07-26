require 'spec_helper'

describe PredictorCreator do
  it 'should create a predictor' do
    Predictors::DataLoader.any_instance.should_receive(:fetch_data).and_return([])
    predictor = stub
    Predictors::Strategies::MostCommon.should_receive(:new).with([], {}).and_return(predictor)
    PredictorCreator.create_predictor('powerball', 'MostCommon').should == predictor
  end
end