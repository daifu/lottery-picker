class HomeController < ApplicationController
  before_filter :set_predictor

  def index
    @super_lotto_numbers = @predictor.predict('supper_lotto', params[:strategy])
  end

  private

  def set_predictor
    @predictor = Predictors::Base.new
  end
end
