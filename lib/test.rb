#!/usr/local/bin/ruby-1.9

require "./interval_tree"
include IntervalTree
itv = [Interval.new(0,3), Interval.new(1,4), Interval.new(3,5),]
t = Tree.new(itv)
t.search(2).each{|x|puts "#{x.first}-#{x.last}"} # => 1-4
puts
t.search(1,3).each{|x|puts "#{x.first}-#{x.last}"} #=> 1-4, 3-5


