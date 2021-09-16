#!/usr/bin/env ruby

module IntervalTree

  class Tree
    def initialize(ranges, &range_factory)
      range_factory = lambda { |l, r| (l ... r+1) } unless block_given?
      ranges_excl = ensure_exclusive_end([ranges].flatten, range_factory)
      @top_node = divide_intervals(ranges_excl)
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
        when k.end.to_r < x_center
          s_left << k
        when k.begin.to_r > x_center
          s_right << k
        else
          s_center << k
        end
      end

      s_center.sort_by! { |x| [x.begin, x.end] }
      
      Node.new(x_center, s_center,
               divide_intervals(s_left), divide_intervals(s_right))
    end

    # Search by range or point
    DEFAULT_OPTIONS = { unique: true }
    def search(query, options = {})
      options = DEFAULT_OPTIONS.merge(options)

      return nil unless @top_node

      if query.respond_to?(:begin)
        result = top_node.search(query)
        options[:unique] ? result.uniq! : result
      else
        result = point_search(self.top_node, query, [], options[:unique])
      end
        result
    end

    def ==(other)
      top_node == other.top_node
    end

    private

    def ensure_exclusive_end(ranges, range_factory)
      ranges.map do |range|
        case
        when !range.respond_to?(:exclude_end?)
          range
        when range.exclude_end?
          range
        else
          range_factory.call(range.begin, range.end)
        end
      end
    end

    def center(intervals)
      (
        intervals.map(&:begin).min.to_r +
        intervals.map(&:end).max.to_r
      ) / 2
    end

    def point_search(node, point, result, unique)
      stack = [node]
      point_r = point.to_r

      until stack.empty?
        node = stack.pop

        node.s_center.each do |k|
          break if k.begin > point
          result << k if point < k.end
        end
        
        if node.left_node && ( point_r < node.x_center )
          stack << node.left_node

        elsif node.right_node && ( point_r >= node.x_center )
          stack << node.right_node
        end

      end
      if unique
        result.uniq
      else
        result
      end
    end
  end # class Tree

  class Node
    def initialize(x_center, s_center, left_node, right_node)
      @x_center = x_center
      @s_center = s_center
      @left_node = left_node
      @right_node = right_node
    end
    attr_reader :x_center, :s_center, :left_node, :right_node

    def ==(other)
      x_center == other.x_center &&
      s_center == other.s_center &&
      left_node == other.left_node &&
      right_node == other.right_node
    end

    # Search by range only
    def search(query)
      search_s_center(query) +
        (left_node && query.begin.to_r < x_center && left_node.search(query) || []) +
        (right_node && query.end.to_r > x_center && right_node.search(query) || [])
    end

    private

    def search_s_center(query)
      result = []

      s_center.each do |k|
        break if k.begin > query.end

        next unless
        (
          # k is entirely contained within the query
          (k.begin >= query.begin) &&
          (k.end <= query.end)
        ) || (
          # k's start overlaps with the query
          (k.begin >= query.begin) &&
          (k.begin < query.end)
        ) || (
          # k's end overlaps with the query
          (k.end > query.begin) &&
          (k.end <= query.end)
        ) || (
          # k is bigger than the query
          (k.begin < query.begin) &&
          (k.end > query.end)
        )
        result << k
      end

      result
    end
  end # class Node

end # module IntervalTree
