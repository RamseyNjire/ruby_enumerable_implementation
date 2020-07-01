# frozen_string_literal: true

module Enumerable
  def my_each
    arr = self
    return to_enum(:my_each) unless block_given?

    arr.size.times { |i| yield(to_a[i]) }
    self
  end
end
