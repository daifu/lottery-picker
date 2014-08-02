module Predictors
  module Strategies
    # Mix most and least common stragtegy
    class Mix < Predictors::Base
      # @params data [Array<Array<String>>] like [["1","2"], ["4", "6"]]
      # @params options [Hash]
      def initialize(data)
        @data = data
      end

      # choose randomly from first k most/least common number with weighted random
      # @params batch_size [Fixnum] the size of number need to be return
      # @params boundary [Fixnum] the boundary of the random numbers
      #
      # @returns [Array]
      def run(batch_size, boundary=10)
        cache = get_count_hash(@data)
        ordered_nums = Hash[cache.sort_by {|key, value| -value}].keys
        most_commons  = ordered_nums.first(boundary * 4 / 5.0)
        least_commons = ordered_nums.last(boundary / 5.0)
        random_select_top_n((most_commons+least_commons).uniq, batch_size)
      end
    end
  end
end