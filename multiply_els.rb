require_relative 'enums.rb'

def multiply_els(arg)
  arg.my_inject { |i, a| i * a }
end
