class Predictors::DataLoader
  def initialize(type)
    @type = type
  end

  def fetch_data
    numbers_string = LotteryNumber.get_numbers_string_by_type(@type)
    numbers_string.map do |string|
      string.split("|")
    end
  end
end