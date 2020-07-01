# frozen_string_literal: true

require_relative 'enums.rb'

my_array = [1, 2, 3, 4, 5]
my_hash = { x: 1, y: 2, z: 3 }

puts '======this is my each method======='
p my_array.my_each
p(my_hash.my_each { |value| p value })
p((1..10).my_each { |value| p value })
