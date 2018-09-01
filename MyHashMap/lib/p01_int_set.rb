class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    raise("Out of bounds") if num > @store.length - 1 || num < 0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.is_a?(integer)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
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
    @store[num % num_buckets]
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
