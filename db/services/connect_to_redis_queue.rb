require 'redis-queue'
# Connect to DB
class ConnectToRedisQueue
  def self.call
    redis = Redis.new
    Redis::Queue.new('github_list_queue','github_list',  :redis => redis)
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
