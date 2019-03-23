require 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    i = key.hash % num_buckets
    if !@store[i].include?(key)
      @store[i] << key
      @count += 1
      if @count > num_buckets
        resize!
      end
    end
  end

  def include?(key)
    i = key.hash % num_buckets
    @store[i].include?(key)
  end

  def remove(key)
    i = key.hash % num_buckets
    if @store[i].include?(key)
      @store[i].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new(num_buckets * 2) { Array.new }
    @store.each do |sub|
      sub.each do |ele|
        i = ele.hash % arr.length
        arr[i] << ele
      end
    end
    @store = arr
  end
end
