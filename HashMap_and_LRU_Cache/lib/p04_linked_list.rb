require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
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
    if @head.next == @tail && @tail.prev == @head
      return true 
    else 
      return false 
    end
  end

  def get(key)
    current_node = @head 
    until current_node == @tail 
      if current_node.key == key 
        return current_node.val 
      else 
        current_node = current_node.next 
      end
    end
  end

  def include?(key)
    return true if get(key)
    false
  end

  def append(key, val)
    node = Node.new(key,val)
    temp = @tail.prev
    node.next = @tail
    @tail.prev = node
    node.prev = temp
    temp.next = node
  end

  def update(key, val)
    current_node = @head 
    until current_node == @tail 
      if current_node.key == key 
        current_node.val = val
        break
      else 
        current_node = current_node.next 
      end
    end
  end

  def remove(key)
    current_node = @head 
    until current_node == @tail 
      if current_node.key == key
        current_node.prev.next = current_node.next
        current_node.next.prev = current_node.prev
        break
      else 
        current_node = current_node.next 
      end
    end
  end

  def each
    current_node = @head.next
    until current_node == @tail 
      yield(current_node)
      current_node = current_node.next 
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
