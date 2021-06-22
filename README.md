# IntervalTree

An implementation of the centered interval tree algorithm in Ruby.

## See also

* [A description of the algorithm in Wikipedia](http://en.wikipedia.org/wiki/Interval_tree)

## ChangeLog

### 2020-11-09, contribution by [Brendan Weibrecht](https://github.com/ZimbiX), [Chris Nankervis](https://github.com/chrisnankervis) and [Thomas van der Pol](https://github.com/tvanderpol)

* Substantially improved performance when supplied with a large range as the search query.

### 2017-05-12, contribution by [Sam Davies](https://github.com/samphilipd)

* User can specify an option in search `unique: false` if s/he wants multiple matches to be returned.

### 2015-11-02, contribution by [Carlos Alonso](https://github.com/calonso)

* Improved centering
* Fixed searching: With some use cases with very large trees, the library fails to find intervals.
* Added rubygems structure to be able to be pushed as a gem

### 2013-04-06, contribution by [Simeon Simeonov](https://github.com/ssimeonov)

* **Range factory**: The current design allows for Range-compatible elements to be added except for the case where `Tree#ensure_exclusive_end` constructs a Range in a private method. In keeping with good design practices of containers such as Hash, this pull requests allows for a custom range factory to be provided to `Tree#initialize` while maintaining perfect backward compatibility.
Search in empty trees failing
* Adds a nil guard in `Tree#search` to protect against empty tree searches failing.
* **Cosmetic improvements**: Language & whitespace in specs, Gemfile addition, and .gitignore update

## Install

```bash
$ gem install fast_interval_tree
```

## Usage

See spec/interval_tree_spec.rb for details.

```ruby
require "interval_tree"

itv = [(0...3), (1...4), (3...5), (0...3)]
t = IntervalTree::Tree.new(itv)
p t.search(2)     #=> [0...3, 1...4]
p t.search(2, unique: false) #=> [0...3, 0...3, 1...4]
p t.search(1...4) #=> [0...3, 1...4, 3...5]
```

Non-range objects can be used with the tree, as long as they respond to `begin` and `end`. This is useful for storing data along side the intervals. For example:
```ruby
require "interval_tree"

CS = Struct.new(:begin, :end, :value) # CS = CustomStruct

itv = [
  CS.new(0,3, "Value"), CS.new(0,3, "Value"),
  CS.new(1,4, %w[This is an array]), CS.new(3,5, %w[A second an array])
]

t = IntervalTree::Tree.new(itv)
pp t.search(2)     
#=> [#<struct CS begin=0, end=3, value="Value">,
#    #<struct CS begin=1, end=4, value=["This", "is", "an", "array"]>]

pp t.search(2, unique: false) 
#=> [#<struct CS begin=0, end=3, value="Value">,
#    #<struct CS begin=0, end=3, value="Value">, 
#    #<struct CS begin=1, end=4, value=["This", "is", "an", "array"]>]

pp t.search(1...4) 
#=> [#<struct CS begin=0, end=3, value="Value">,
#    #<struct CS begin=1, end=4, value=["This", "is", "an", "array"]>,
#    #<struct CS begin=3, end=5, value=["A", "second", "an", "array"]>]
```

## Note

Result intervals are always returned
in the "left-closed and right-open" style that can be expressed
by three-dotted Range object literals `(begin...end)`

Two-dotted full-closed intervals `(begin..end)` are also accepted and internally
converted to half-closed intervals.

When using custom objects the tree assumes the "left-closed and right-open" style (i.e. the `end` property is not
considered to be inside the interval).

## Copyright

**Author**: MISHIMA, Hiroyuki ( https://github.com/misshie ),  Simeon Simeonov ( https://github.com/ssimeonov ), Carlos Alonso ( https://github.com/calonso ), Sam Davies ( https://github.com/samphilipd ), Brendan Weibrecht (https://github.com/ZimbiX), Chris Nankervis (https://github.com/chrisnankervis), Thomas van der Pol (https://github.com/tvanderpol).

**Copyright**: (c) 2011-2020 MISHIMA, Hiroyuki; Simeon Simeonov; Carlos Alonsol; Sam Davies; Brendan Weibrecht; Chris Nankervis; Thomas van der Pol

**License**: The MIT/X11 license
