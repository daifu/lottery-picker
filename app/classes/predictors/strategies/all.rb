module Predictors
  module Strategies
    class All < Predictors::Base
      # Choose all the weighted random
      #
      # @returns [Array]
      def use_sample
        @data_frequency_hash
      end
    end
  end
end