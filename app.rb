require 'redis'
require 'byebug'
require 'json'

class App
  attr :redis, :data
  def initialize
    @redis = Redis.new
  end

  def set_defaults
    redis.set('data', {}.to_json)
  end

  def request_handled(ip_address)
    hash = JSON.parse(redis.get('data'))
    hash.default = 0

    hash[ip_address] += 1
    redis.set('data', hash.to_json)
  end

  def top100(limit = 100)
    hash = JSON.parse(redis.get('data'))

    hash.sort_by {|k, v| -v}.first(limit).to_h
  end

  def clear
    redis.flushall
  end

  def data
    JSON.parse(redis.get('data'))
  end
end

app = App.new
app.set_defaults

10000.times do |i|
  random_number = rand(1..100)
  ip_address = "145.87.2.#{random_number}"

  app.request_handled(ip_address)
end

puts app.top100