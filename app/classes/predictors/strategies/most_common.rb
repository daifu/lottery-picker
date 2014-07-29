module Predictors
  module Strategies
    class MostCommon < Predictors::Base
      # @params data [Array<Array<String>>] like [["1","2"], ["4", "6"]]
      # @params options [Hash]
      def initialize(data)
        @data = data
      end

      # choose randomly from first k most common number with weighted random
      # @params batch_size [Fixnum] the size of number need to be return
      # @params boundary [Fixnum] the boundary of the random numbers
      #
      # @returns [Array]
      def run(batch_size, boundary=10)
        cache = get_count_hash(@data)
        most_commons = Hash[cache.sort_by {|key, value| -value}].keys.first(boundary)
        random_select_top_n(most_commons, batch_size)
      end
    end
  end
end