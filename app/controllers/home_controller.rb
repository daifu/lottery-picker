class HomeController < ApplicationController
  before_filter :set_predictor

  def index
    @home_presenters = HomePresenter.new(@predictor, params)
  end

  private

  def set_predictor
    @predictor = Predictors::Base.new
  end
end
