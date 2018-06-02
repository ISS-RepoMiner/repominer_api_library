require 'redis-queue'
# Connect to DB
class ConnectToRedisQueue
  def self.call(queue_name, process_queue_name, config)
    redis = Redis.new(host: config.REDIS_HOST, port: config.REDIS_PORT, db: config.REDIS_DB)
    Redis::Queue.new(queue_name, process_queue_name,  :redis => redis)
  end
end

class ConnectToRedisQueueTmp
  def self.call
    redis = Redis.new
    Redis::Queue.new('forks_queue','forks_list',  :redis => redis)
  end
end

class ConnectToPatchErrorQueue
  def self.call
    redis = Redis.new
    Redis::Queue.new('patch_error_queue','patch_error',  :redis => redis)
  end
end
