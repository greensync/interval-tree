#!/usr/local/bin/ruby-1.9
#
# Title: the IntervalTree module
# Author: MISHIMA, Hiroyuki ( https://github.com/misshie )
# 
# Original code written in Python that is available at
# http://forrst.com/posts/Interval_Tree_implementation_in_python-e0K
# 
# Usage:
#  require "interval_tree"
#  include IntervalTree
#  itv = [Interval.new(0,3), Interval.new(1,4), Interval.new(3,5),]
#  t = Tree.new(itv)
#  t.search(2).each{|x|pus "#{x.first}-#{x.last}"} # => 1-4
#  t.search(1,3).each{|x|puts "#{x.first}-#{x.last}"} #=> 1-4, 3-5
#
# note: intevels are "left-closed and right-open, i.e. [first, last)"
#

module IntervalTree

  class Tree
    def initialize(intervals)
      @top_node = divide_intervals(intervals)
    end
    attr_reader :top_node

    def divide_intervals(intervals)
      return nil if intervals.empty?
      x_center = center(intervals)
      s_center = Array.new
      s_left = Array.new
      s_right = Array.new

      intervals.each do |k|
        case
        when k.first < x_center
          s_left << k
        when x_center < k.first
          s_right << k
        else
          s_center << k
        end
      end
      Node.new(x_center, s_center,
               divide_intervals(s_left), divide_intervals(s_right))
    end

    def center(intervals)
      fs = intervals.sort_by{|x|x.first}
      fs[fs.length/2].first
    end

    def search(first, last = nil)
      if last
        result = Array.new        
        (first..last+1).each do |j|
          search(j).each{|k|result << k}
          result.uniq!
        end
        result.sort_by{|x|x.first}
      else
        point_search(self.top_node, first, [])
      end
    end
    
    private

    def point_search(node, point, result)
      node.s_center.each do |k|
        result << k if (k.first <= point) && (point <= k.last) 
      end
      if (point < node.x_center) && node.left_node
        point_search(node.left_node, point, []).each{|k|result << k}
      end
      if (node.x_center < point) && node.right_node
        point_search(node.right_node, point, []).each{|k|result << k}
      end
      result.uniq
    end
  end # class Tree

  class Interval
    def initialize(first, last)
      @first = first
      @last = last
    end
    attr_reader :first, :last
    alias :begin :first
    alias :end :last
  end # class Interval

  class Node
    def initialize(x_center, s_center, left_node, right_node)
      @x_center = x_center
      @s_center = s_center.sort_by{|x|x.first}
      # @s_center_first = s_center.sort_by{|x|x.first}
      # @s_center_last  = s_center.sort_by{|x|x.last}
      @left_node = left_node
      @right_node = right_node
    end
    attr_reader :x_center, :s_center, :left_node, :right_node
  end # class Node

end # module IntervalTree

if  __FILE__ == $0
  puts "Interval Tree Library"
end
