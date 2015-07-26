class HomeController < ApplicationController
  before_filter :set_predictor_creator

  def index
    @home_presenters = HomePresenter.new(@predictor_creator, params)
  end

  private

  def set_predictor_creator
    @predictor_creator = PredictorCreator.new
  end
end
