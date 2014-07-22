class LotteryNumber < ActiveRecord::Base
  validates :type_id, :presence => true
  validates :draw_date, :presence => true

  GAMES = {
    'superlotto-plus' => 1,
    'powerball' => 2,
    'mega-millions' => 3,
    'fantasy-5' => 4,
    'daily-4' => 5,
    'daily-3' => 6
  }

  def get_numbers_string_by_type(type)
    self.where("game_id=#{LotteryNumber::Games[@type]}").pluck(:numbers_string)
  end
end