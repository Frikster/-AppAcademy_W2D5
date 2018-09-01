require 'byebug'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if @count >= num_buckets
      resize!
    end
    if include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @count -= 1 if @store[bucket(key)].remove(key)
  end

  def each(&prc)
    @store.each do |ll|
      ll.each do |node|
        prc.call(node.key, node.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_one = HashMap.new(num_buckets * 2)
    self.each do |k, v|
      new_one.set(k, v)
    end
    @store = new_one.store
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
