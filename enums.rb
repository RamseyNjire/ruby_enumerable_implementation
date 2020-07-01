module Enumerable
  def my_each
    arr = self
    return to_enum(:my_each) unless block_given?

    arr.size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    self.my_each do |i|
      yield(i, self.index(i))
    end
    self
  end

  def my_all?
    return to_enum(:my_each_with_index) unless block_given?
    
    self.my_each do |i|
      return false unless yield(i)
    end

    true
  end

  def my_any?
    return to_enum(:my_each_with_index) unless block_given?
    
    self.my_each do |i|
      return true if yield(i)
    end

    false
  end

  def my_map
    modified_array = []

    self.my_each do |i|
      modified_array << yield(i)
    end

    modified_array
  end
end