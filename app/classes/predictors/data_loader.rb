class Predictors::DataLoader
  def fetch_data(type)
    numbers_string = LotteryNumber.get_numbers_string_by_type(type)
    numbers_string.map do |string|
      string.split("|")
    end
  end
end