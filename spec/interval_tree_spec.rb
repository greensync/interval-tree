require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'interval_tree'

describe "IntervalTree::Interval" do

  describe ".new" do
    context 'given (0,10)' do
      it 'returns interval object' do
        IntervalTree::Interval.new(0, 10).should be_a IntervalTree::Interval
      end
    end
  end

  describe ".first" do
    context 'given (20,30)' do
      it 'returns 20' do
        IntervalTree::Interval.new(20, 30).first.should == 20
      end
    end
  end
  
end

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

  describe '.new' do
    context 'given [Interval.new(1, 5)]' do
      it 'returns an Tree objects' do
        itvs = [IntervalTree::Interval.new(1, 5),]
        IntervalTree::Tree.new(itvs).should be_a(IntervalTree::Tree)
      end
    end
  end

  describe '.search' do
    context 'given an array of a interval (1,5] and a point query "3"' do
      it 'returns an array of intervals (1,5]' do
        itvs = [IntervalTree::Interval.new(1, 5),]
        tree = IntervalTree::Tree.new(itvs).search(3)
        tree.should  == itvs
      end
    end

    context 'given an array of a interval (1,5]/(2,6] and a point query "3"' do
      it 'returns an array of intervals (1,5]/(2,6]' do
        itvs = [IntervalTree::Interval.new(1, 5),
                IntervalTree::Interval.new(2, 6),]
        tree = IntervalTree::Tree.new(itvs).search(3)
        tree.should  == itvs
      end
    end
  end

end                             
