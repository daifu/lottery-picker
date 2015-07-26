require 'spec_helper'

describe Selectors::WeightedRandomSelector do
  let(:data_selected_from) { [6, 2, 3, 4, 5, 8, 9] }
  let(:data_weights) { [0.1, 0.2, 0.2, 0.3, 0.1, 0.6, 0.1] }

  let(:tree) {
    [
      Hashie::Mash.new(:data => 6, :weight => 0.1, :total_weight => 1.6, :node_index => 0),
      Hashie::Mash.new(:data => 2, :weight => 0.2, :total_weight => 0.6, :node_index => 1),
      Hashie::Mash.new(:data => 3, :weight => 0.2, :total_weight => 0.9, :node_index => 2),
      Hashie::Mash.new(:data => 4, :weight => 0.3, :total_weight => 0.3, :node_index => 3),
      Hashie::Mash.new(:data => 5, :weight => 0.1, :total_weight => 0.1, :node_index => 4),
      Hashie::Mash.new(:data => 8, :weight => 0.6, :total_weight => 0.6, :node_index => 5),
      Hashie::Mash.new(:data => 9, :weight => 0.1, :total_weight => 0.1, :node_index => 6),
    ]
  }

  it 'should pick numbers based on their weights' do
    Random.srand(12345) # Set random seed to a fixed number
    selector = Selectors::WeightedRandomSelector.new(data_selected_from, data_weights)
    selector.select(3).should == [8,4,2] # Set random seed to a random number
    Random.srand
  end

  it 'should create a correct binary tree' do
    selector = Selectors::WeightedRandomSelector.new(data_selected_from, data_weights)
    selector.create_binary_tree.should == tree
  end

  it 'should pop correct data from tree' do
    Random.srand(993)
    selector = Selectors::WeightedRandomSelector.new(data_selected_from, data_weights)
    # random_weight = 0.395
    selector.pop_data_from_tree(tree).should == 4
    Random.srand
  end

  it 'can use the default weights' do
    Random.srand(12345) # Set random seed to a fixed number
    selector = Selectors::WeightedRandomSelector.new(data_selected_from)
    selector.select(3).should == [9, 5, 4] # Set random seed to a random number
    Random.srand
  end
end