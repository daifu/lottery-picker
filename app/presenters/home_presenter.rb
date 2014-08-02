class HomePresenter
  STRATEGIES = ['MostCommon', 'LeastCommon', 'Mix']

  def initialize(predictor, params)
    @strategy  = params[:strategy] || 'MostCommon'
    @predictor = predictor
    @cache     = RedisCache.new(:expire_in => 1.day)
    @refresh   = params[:refresh]
  end

  def games
    delete_all if @refresh
    @games = if !@cache.exists(@strategy)
               games = LotteryNumber::GAMES.each_with_object({}) do |(name, _), memo|
                 memo[name] = @predictor.predict(name, @strategy)
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