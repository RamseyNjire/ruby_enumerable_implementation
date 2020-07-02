# frozen_string_literal: true

module Enumerable
  def my_each
    arr = self
    return to_enum(:my_each) unless block_given?

    arr.size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    my_each do |i|
      yield(i, index(i))
    end
    self
  end

  def my_all?
    return to_enum(:my_each_with_index) unless block_given?

    my_each do |i|
      return false unless yield(i)
    end

    true
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each do |i|
      new_array.push(i) if yield(i)
    end
    new_array
  end

  def my_any?
    return to_enum(:my_each_with_index) unless block_given?

    my_each do |i|
      return true if yield(i)
    end

    false
  end

  def my_none?(_arg = nil)
    my_each do |i|
      if block_given?
        return false if yield(i)
      else
        return false if !i.nil? && i != false
      end
    end
    true
  end

  def my_count (arg=nil)
    count=[]
    if block_given?
      self.my_each do |i|
        count.push(yield(i))
      end
    elsif arg !=nil
      self.my_select do |i|
        count<<arg if arg==1
      end
    else
      self.length if arg==nil
    end

  end

  def my_map
    modified_array = []

    my_each do |i|
      modified_array << yield(i)
    end

    modified_array
  end

 
end
