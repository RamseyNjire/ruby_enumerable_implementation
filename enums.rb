# frozen_string_literal: true

module Enumerable
  def my_each
    arr = self
    return to_enum(:my_each) unless block_given?

    arr.size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    arr = self
    return to_enum(:my_each) unless block_given?

    arr.size.times {|i| yield(to_a[i], i)}

    self
  end

  def my_all?(arg = nil)

    if block_given? && !arg.nil?
      return false unless my_all?(arg) && my_all?
    end
    if block_given?
      my_each {|i| return false unless yield(i)}
    elsif arg.nil?
      my_each {|i| return false unless i}
    elsif arg.class == Class
      my_each {|i| return false unless i.class <= arg}
    elsif arg.class == Regexp
      my_each {|i| return false unless i =~ arg}
    else
      my_each {|i| return false unless i == arg && i.class <= arg.class}
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

  def my_any?(arg = nil)
    
    if block_given? && !arg.nil?
      return true unless my_any?(arg) && my_any?
    end
    
    if block_given?
      my_each {|i| return true unless yield(i)}
    elsif arg.nil?
      my_each {|i| return true unless i}
    elsif arg.class == Class
      my_each {|i| return true unless i.class <= arg}
    elsif arg.class == Regexp
      my_each {|i| return true unless i =~ arg}
    else
      my_each {|i| return true unless i == arg && i.class <= arg.class}
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

  def my_count(arg = nil)
    count = []
    if block_given?
      my_each do |i|
        count.push(yield(i))
      end
    elsif !arg.nil?
      my_select do |_i|
        count << arg if arg == 1
      end
    else
      length if arg.nil?
    end
  end

  def my_map(&arg)
    

    return to_enum(:my_map) unless block_given?

    modified_array = []
    my_each {|i| modified_array << arg.call(i)}

    modified_array
  end

  def my_inject(*arg)
    raise LocalJumpError unless block_given? || !arg.empty?

    sym = arg.pop unless block_given?
    my_array = arg + to_a
    memo = my_array.shift
    if block_given?
      my_array.my_each { |el| memo = yield(memo, el) }
    else
      my_array.my_each { |el| memo = memo.send(sym, el) }
    end
    memo
  end  

  def multiply_els
    my_inject { |i, a| i * a }
  end
  
end