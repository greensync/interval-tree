#!/usr/local/bin/ruby-1.9

module IntervalTree

  class Node
    def initialize(x_center, s_center, left_node, right_node)
      @x_center = x_center
      @s_center = s_center
      @left_node = left_node
      @right_node = right_node
    end
  end

end

if  __FILE__ == $0
  puts "Interval Tree Library"
end
