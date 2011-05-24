require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# describe "IntervalTree" do
  
#   # describe ".initialize" do
#   #   context 'given a interval (1...100)' do 
#   #     it "returns a <TBA>" do
#   #       #
#   #     end
#   # end

# end

describe "IntervalTree::Node" do

  describe '.new' do
    context 'given (nil, nil, nil, nil)' do
      it 'returns a Node instance' do
        IntervalTree::Node.new(nil, nil, nil, nil).should be_a(IntervalTree::Node)
      end
    end
  end
 
end
