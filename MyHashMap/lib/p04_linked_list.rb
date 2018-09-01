class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable 
  
  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return @head.next == @tail
  end

  def get(key)
    node = first
    until node == @tail
      if node.key == key
        return node.val
      end
      node = node.next
    end
    nil
  end

  def include?(key)
    return true if get(key)
    return false
  end

  def append(key, val)
    node = Node.new(key, val)
    current_last = last
    current_last.next = node
    node.prev = current_last
    @tail.prev = node
    node.next = @tail
  end

  def update(key, val)
    each do |node| 
      if node.key == key
        node.val = val
      end
    end
    nil
  end

  def remove(key)
    each do |node| 
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
        node.prev = nil
        node.next = nil
        return node
      end
    end
    nil
  end

  def each(&prc)
    node = @head.next
    until node == @tail
      next_node = node.next
      prc.call(node)
      node = next_node
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
