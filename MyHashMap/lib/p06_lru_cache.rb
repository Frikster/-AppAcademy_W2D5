require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    val = prc.call(key)
    @map.set(key, val)
    @store.delete(key) #O(n)
    @store.appent()
    # @map.get(key).val if @map.get(key)
  end

  def to_s  
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    debugger
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end
