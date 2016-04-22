class Link
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
end

class LinkedList

  include Enumerable

  attr_reader :links

  def initialize
    @links = []
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @links.first
  end

  def last
    @links.last
  end

  def empty?
    @links.empty?
  end

  def get(key)
    @links.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    @links.each do |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    if @links.empty?
      @links << Link.new(key, val)
    elsif @links.any? {|link| link.key == key}
      self.each {|link| link.val = val if link.key == key}
    else
      @links << Link.new(key, val)
      @links.last.prev = @links[-2]
      @links[-2].next = @links.last
    end
  end

  def remove(key)
    @links.each do |link|
      if link.key == key
        pre_k = link.prev
        post_k = link.next

        pre_k.next = post_k if pre_k
        post_k.prev = pre_k if post_k

        @links.delete(link)
        break
      end
    end
  end

  def each
    current = first
    while current
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
