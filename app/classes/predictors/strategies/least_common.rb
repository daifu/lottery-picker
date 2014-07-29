module Predictors
  module Strategies
    class LeastCommon < Predictors::Base
      # @params data [Array<Array<String>>] like [["1","2"], ["4", "6"]]
      # @params options [Hash]
      def initialize(data)
        @data = data
      end

      # Choose first k number with weighted random
      #
      # @returns [Array]
      def run(batch_size, boundary=10)
        cache = get_count_hash(@data)
        least_commons = Hash[cache.sort_by {|key, value| value}].keys.first(boundary)
        random_select_top_n(least_commons, batch_size)
      end
    end
  end
end