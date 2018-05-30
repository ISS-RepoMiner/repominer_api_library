# Get the correspond github list from gem_basic_info
class PushRecordToRedis
  def initialize(redis_queue)
    @redis_queue = redis_queue
  end

  def write(row)
    @redis_queue.push row
  end
end
