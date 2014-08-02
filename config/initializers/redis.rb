# Create config/redis.yml to use anything other than localhost
conf_file = File.join('config', 'redis.yml')

$redis = if File.exists?(conf_file)
           conf = YAML.load(File.read(conf_file))
           conf[Rails.env.to_s].blank? ? Redis.new : Redis.new(conf[Rails.env.to_s])
         else
           Redis.new
         end