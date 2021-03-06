require 'redis'
require 'ihasa/version'
require 'ihasa/bucket'

# Ihasa module. Root of the Ihasa::Bucket class
module Ihasa
  module_function

  def default_redis
    @redis ||= if ENV['REDIS_URL']
                 Redis.new url: ENV['REDIS_URL']
               else
                 Redis.new
               end
  end

  DEFAULT_PREFIX = 'IHAB'.freeze
  def bucket(rate: 5, burst: 10, prefix: DEFAULT_PREFIX, redis: default_redis)
    Bucket.new(rate, burst, prefix, redis).tap(&:initialize_redis_namespace)
  end
end
