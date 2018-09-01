# class HashSet
#   attr_reader :count
# 
#   def initialize(num_buckets = 8)
#     @store = Array.new(num_buckets) { Array.new }
#     @count = 0
#   end
# 
#   def insert(key)
#   end
# 
#   def include?(key)
#   end
# 
#   def remove(key)
#   end
# 
#   private
# 
#   def [](num)
#     # optional but useful; return the bucket corresponding to `num`
#   end
# 
#   def num_buckets
#     @store.length
#   end
# 
#   def resize!
#   end
# end

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count >= num_buckets
      resize!
    end
    if !include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    @count -= 1 if self[num].delete(num) 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    res = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        res[el % (num_buckets * 2)] << el
      end
    end
    @store = res
  end
end
