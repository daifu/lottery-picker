require 'net/http'
class Utils
  def self.create_temp_file(type = "utils_tmp", prefix = "tmp", options = {})
    filename = create_temp_filename(type, prefix, options)
    file = File.open(filename, 'wb')

    if block_given?
      yield file
      file.close
      return filename
    else
      file
    end
  end

  def load_file_to_db(file)
    
  end

  def self.download_game_file(game_name)
    base = "www.calottery.com"
    path = "/sitecore/content/Miscellaneous/download-numbers/?GameName=#{game_name}"
    Utils.create_temp_file do |tmp_file|
      Net::HTTP.start(base) do |http|
        resp = http.get(path)
        tmp_file.write(resp.body)
      end
    end
  end

  def self.create_temp_filename(type = "util_tmp", prefix = "tmp", options = {})
    outdir = File.join(Rails.root, "tmp", type)
    FileUtils.mkdir_p(outdir) unless Dir.exists?(outdir)
    filename_parts = [prefix, Time.now.strftime('%y%m%d%H%M%S'), SecureRandom.hex(3)]
    filename_base = filename_parts.join("-")
    File.join(outdir, filename_base)
  end
end