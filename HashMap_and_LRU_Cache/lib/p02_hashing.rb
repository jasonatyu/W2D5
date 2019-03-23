class Integer
  # Integer#hash already implemented for you

end

class Array
  def hash
    result = 0
    self.each_with_index do |ele, i|
      result += (ele * i).hash
    end
    result
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    result = 0
    self.each_char.with_index do |c, i|
      result += (alphabet.index(c.downcase) * i).hash
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a
    result = 0
    arr.each do |sub|
    result += sub[0].hash + sub[1].hash
    end
    result
  end
end
