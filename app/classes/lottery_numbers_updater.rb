class LotteryNumbersUpdater
  FILE_HEADER = ['game_id', 'draw_id', 'draw_date', 'numbers_string', 'created_at', 'updated_at']

  # Update all the games from california lottery
  # 1. download the file from califronia lottery
  # 2. Parse it and load it to the db
  def self.update_all
    game_hash.keys.each do |game|
      game_id  = LotteryNumber::GAMES[game]
      raw_file = Utils.download_game_file(game)
      file     = convert_file(raw_file, game_id)

      DbImporter.import_simple_table('lottery_numbers', FILE_HEADER, file, {
        :delete_records     => true,
        :unique_batch_value => game_id,
        :unique_batch_key   => 'game_id',
        :delete_records     => true
      })
    end
  end

  # Convert the file to CSV file that can be
  # load into db using COPY
  def self.convert_file(file, game_id)
    lines = []
    rows  = []

    File.open(file, 'r') do |f|
      5.times {f.gets} # remove headers
      while(line = f.gets)
        lines << line.strip
      end
    end

    rows = tokenize_lines(lines, game_id)

    Utils.create_temp_file do |file|
      file.puts(FILE_HEADER.join(','))
      rows.each do |row|
        file.puts(row.join(','))
      end
    end
  end

  # For spec stubing
  def self.game_hash
    LotteryNumber::GAMES
  end

  private

  # tokenize lines and get deails data from each line
  # @returns [Array<Array>]
  def self.tokenize_lines(lines, game_id)
    long_space  = "          "
    short_space = "     "
    lines.inject([]) do |rows, line|
      draw_id,draw_date = line.split(short_space)
      numbers_string    = line.split(long_space)[1..-1]
      now               = Time.now.utc.to_s(:db)
      rows << [game_id, draw_id, Time.parse(draw_date).utc.to_s(:db), numbers_string.join("|"),now, now]
      rows
    end
  end
end