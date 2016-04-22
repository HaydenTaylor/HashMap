require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[(key.hash % @store.length)].include?(key)
  end

  def set(key, val)
    @store[(key.hash % @store.length)].insert(key, val)
    @count += 1
  end

  def get(key)
    @store[(key.hash % @store.length)].get(key)
  end

  def delete(key)
    @store[(key.hash % @store.length)].remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        [link.key, link.val]
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
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
