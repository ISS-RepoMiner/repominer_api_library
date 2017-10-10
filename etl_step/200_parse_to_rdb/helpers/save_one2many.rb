require 'sequel'

class SaveOne2Many
  def initialize(object1, object2, method)
    @object1 = object1
    @object2 = object2
    @method = method
  end

  def write(row)
    obj=@object1.new(row[0])
    ojb.save
    @object2.find(repo_name: row[1]).send @method, obj

  end

  def close
    @db.disconnect
  end
end
