class HomePresenter
  STRATEGIES = ['MostCommon', 'LeastCommon', 'Mix', 'All']

  def initialize(predictor_creator, params)
    @strategy          = params[:strategy] || 'MostCommon'
    @predictor_creator = predictor_creator
    @cache             = RedisCache.new(:expire_in => 1.day)
    @refresh           = params[:refresh]
  end

  def games
    delete_all if @refresh
    @games = if !@cache.exists(@strategy)
               games = LotteryNumber::GAMES.each_with_object({}) do |(game_type, _), memo|
                 predictor       = @predictor_creator.create_predictor(game_type, @strategy)
                 memo[game_type] = predictor.predict
               end
               @cache.set(@strategy, games.to_json)
               games
             else
               @cache.get(@strategy)
             end
  end

  def active_class(x)
    @strategy == x ? 'ui-btn-active' : ''
  end

  private

  def delete_all
    STRATEGIES.each {|s| @cache.empty!(s)}
  end

end