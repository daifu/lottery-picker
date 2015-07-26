class PredictorCreator
  def create_predictor(game_type, strategy, params = {})
    data_loader = Predictors::DataLoader.new(game_type)
    lists       = data_loader.fetch_data
    "Predictors::Strategies::#{strategy}".constantize.new(lists, params)
  end
end