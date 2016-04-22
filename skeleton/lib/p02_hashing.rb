class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 512 if self.empty?
    hashed = 0
    self.each_with_index do |e, i|
      hashed += e.hash * i
    end
    hashed
  end
end

class String
  def hash
    hashed = 0
    self.chars.each_with_index do |e, i|
      hashed += e.ord * i
    end
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    self.each_pair do |k, v|
      hashed += k.to_s.ord + v.to_s.ord
    end
    hashed
  end
end

class Symbol
  def hash
    self.to_s.ord.hash
  end
end
