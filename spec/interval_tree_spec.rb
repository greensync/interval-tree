require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'interval_tree'

describe "IntervalTree::Node" do

  describe '.new' do
    context 'given ([], [], [], [])' do
      it 'returns a Node object' do
        IntervalTree::Node.new([], [], [], []).should be_a(IntervalTree::Node)
      end
    end
  end
 
end

describe "IntervalTree::Tree" do

  describe '#center' do
    context 'given [(1...5),]' do
      it 'returns 1' do
        itvs = [(1...5),]
        t = IntervalTree::Tree.new([])
        t.__send__(:center, itvs).should == 1

      end
    end

    context 'given [(1...5), (2...6)]' do
      it 'returns 2' do
        itvs = [(1...5), (2...6),]
        t = IntervalTree::Tree.new([])
        t.__send__(:center, itvs).should == 2
      end
    end
  end

  describe '.new' do
     context 'given [(1...5),]' do
       it 'returns an Tree objects' do
         itvs = [(1...5),]
         IntervalTree::Tree.new(itvs).should be_an IntervalTree::Tree
      end
    end
  
    context 'given [(1...5),(2...6), (3...7)]' do
      it 'returns ret.top_node.x_centeran == 2 ' do
        itvs = [(1...5),(2...6), (3...7)]
        tree = IntervalTree::Tree.new(itvs)
        tree.top_node.x_center.should == 2
      end
    end
  end

  describe '#search' do
    context 'given [(1...5)] a point query "3"' do
      it 'returns an array of intervals (1...5)]' do
        IntervalTree::Tree.new([1...5]).search(3).should == [1...5]
      end
    end
    
    context 'given non-array full-closed "(1..4)" and a point query "3"' do
      it 'returns an array contains a half-open interval (1...5)]' do
        IntervalTree::Tree.new(1..4).search(3).should == [1...5]
      end
    end
    
    context 'given [(1...5), (2...6)] and a point query "3"' do
      it 'returns [(1...5), (2...6)]' do
        itvs = [(1...5), (2...6),]
        results = IntervalTree::Tree.new(itvs).search(3)
        results.should  == itvs
      end
    end

    context 'given [(0...8), (1...5), (2...6)] and a point query "3"' do
      it 'returns [(0...8), (1...5), (2...6)]' do
        itvs = [(0...8), (1...5), (2...6)]
        results = IntervalTree::Tree.new(itvs).search(3)
        results.should  == itvs
      end
    end

    context 'given [(0...8), (1...5), (2...6)] and a query by (1...4)' do
      it 'returns [(0...8), (1...5), (2...6)]' do
        itvs = [(0...8), (1...5), (2...6)]
        results = IntervalTree::Tree.new(itvs).search(1...4)
        results.should  == itvs
      end
    end

    context 'given [(1...3), (3...5)] and a query by 3' do
      it 'returns [(3...9)]' do
        results = IntervalTree::Tree.new([(1...3), (3...5)]).search(3...9)
        results.should  == [(3...5)]
      end
    end

    context 'given [(1...3), (3...5), (4...8)] and a query by (3...5)' do
      it 'returns [(3...5), (4...8)]' do
        itvs = [(1...3), (3...5), (4...8)]
        results = IntervalTree::Tree.new(itvs).search(3...5)
        results.should  == [(3...5), (4...8)]
      end
    end

    context 'given [(1...3), (3...5), (3...9), (4...8)] and a query by (3...5)' do
      it 'returns [(3...5), (3...9), (4...8)]' do
        itvs = [(1...3), (3...5), (3...9), (4...8)]
        results = IntervalTree::Tree.new(itvs).search(3...5)
        results.should  == [(3...5), (3...9), (4...8)]
      end
    end

  end

end

