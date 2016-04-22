require 'byebug'

class MaxIntSet
  attr_reader :max
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(1,@max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store.each do |bucket|
      if bucket.empty?
        bucket << num
        break
      end
    end
  end

  def remove(num)
    @store.each do |bucket|
      # byebug
      bucket.clear if bucket == [num]
    end
  end

  def include?(num)
    @store.any? { |bucket| bucket == [num] }
  end

  private

  def [](num)
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
    resize! if @count == (@store.length - 1)
    ((@store[num % num_buckets] << num) && (@count += 1))
  end

  def remove(num)
    ((@store[num % num_buckets].delete(num)) && (@count -= 1))
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num % new_store.length] << num
      end
    end
    @store = new_store
  end

end
