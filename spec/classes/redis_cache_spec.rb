require 'spec_helper'

describe RedisCache do
  let(:redis) {RedisCache.new}
  it "should raise exception if value is not a json" do
    expect{ redis.set('test', 'not a json') }.to raise_error
  end

  it "should have full features to redis" do
    redis.set('test', '{}')
    redis.exists('test').should be_true
    redis.get('test').should == {}
    redis.empty!('test')
    redis.exists('test').should be_false
  end
end