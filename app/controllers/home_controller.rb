class HomeController < ApplicationController
  before_filter :set_predictor

  def index
    @strategy = params[:strategy] || 'MostCommon'
    @type     = params[:type] || 'superlotto-plus'
    @super_lotto_numbers = @predictor.predict(@type, @strategy)
  end

  private

  def set_predictor
    @predictor = Predictors::Base.new
  end
end
