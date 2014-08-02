class LotteryNumber < ActiveRecord::Base
  validates :game_id, :presence => true
  validates :draw_date, :presence => true

  GAMES = {
    'superlotto-plus' => 1,
    'powerball'       => 2,
    'mega-millions'   => 3,
    'fantasy-5'       => 4,
    'daily-4'         => 5,
    'daily-3'         => 6
  }

  def self.get_numbers_string_by_type(type)
    raise RuntimeError, "No matching game[#{type}]" if GAMES[type].nil?
    self.where("game_id=#{GAMES[type]}").pluck(:numbers_string)
  end
end