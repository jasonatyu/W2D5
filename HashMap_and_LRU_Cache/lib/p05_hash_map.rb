require 'byebug'
require_relative 'p04_linked_list'
require_relative 'p02_hashing'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i = key.hash % num_buckets
    @store[i].include?(key) 
  end

  def set(key, val)
    i = key.hash % num_buckets
    if get(key).nil?
      @store[i].append(key,val)
      @count += 1
      if @count > num_buckets
        resize!
      end
    else
      @store[i].update(key,val)
    end
  end

  def get(key)
    i = key.hash % num_buckets
    @store[i].get(key)
  end

  def delete(key)
    i = key.hash % num_buckets
    if @store[i].include?(key)
      @store[i].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |sub|
      sub.each do |k,v|
        i = k.hash % arr.length
        arr[i].append(k,v)
      end
    end
    @store = arr
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
