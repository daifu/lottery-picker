class Predictors::Base
  SAMPLE_SIZE_FACTOR = 3

  def initialize(data, options={})
    @data                = data
    @selector_strategy   = options[:selecor_strategy] || 'WeightedRandomSelector'
    @batch_size          = data.first.size
    @sample_size         = @batch_size * SAMPLE_SIZE_FACTOR
  end

  def predict
    @data_frequency_hash = aggregate_data_with_frequency
    sample               = use_sample
    @selector = "Selectors::#{@selector_strategy}".constantize.new(sample.keys, sample.values)
    @selector.select(@batch_size)
  end

  # create a sample data based on the strategy
  # @return [Hash] {number => weight of that number}
  def use_sample
    raise NotImplementedError.new("Subclass should implement it")
  end

  # Get a hash that having the frequency of the numbers appear
  # in the lottery
  #
  # @params data [Array<Array<String>>], like [["1", "5"],["5","6"]]
  # @returns [Hash] a hash like {num => frequency of the number}
  def aggregate_data_with_frequency
    cache = Hash.new(0)

    @data.each do |numbers|
      numbers.each do |num|
        cache[num] += 1
      end
    end

    cache
  end
end