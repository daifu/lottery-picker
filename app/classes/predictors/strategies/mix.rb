module Predictors
  module Strategies
    # Mix most and least common stragtegy
    class Mix < Predictors::Base
      # choose randomly from first k most/least common number with weighted random
      #
      # @returns [Array]
      def use_sample
        ordered_nums  = @data_frequency_hash.sort_by { |key, value| -value }
        most_commons  = ordered_nums.first(@sample_size * 4 / 5.0)
        least_commons = ordered_nums.last(@sample_size / 5.0)
        Hash[most_commons + least_commons]
      end
    end
  end
end