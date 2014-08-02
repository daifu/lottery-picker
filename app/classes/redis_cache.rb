class RedisCache
  attr_accessor :on, :redis
  delegate :exists, :to => :redis

  def initialize(option={})
    @redis = $redis
    @option = option
  end

  # Empty the cache by key
  def empty!(key)
    @redis.del(key)
  end

  def get(key)
    val = @redis.get(key)
    JSON.parse val if val
  end

  def set(key, value)
    raise "value [#{value}] is not a json string" unless is_json?(value)
    @redis.set(key, value)
    @redis.expire(key, @option[:expire_in].to_i) if @option[:expire_in]
  end

  private

  def is_json?(str)
    begin
      !!JSON.parse(str)
    rescue
      false
    end
  end
end