module Predictors
  module Strategies
    class MostCommon < Predictors::Base
      # choose randomly from first k most common number with weighted random
      #
      # @returns [Array]
      def use_sample
        Hash[@data_frequency_hash.sort_by {|key, value| -value}.first(@sample_size)]
      end
    end
  end
end