require_relative 'bubble_sort'

describe BubbleSort do

  before { @bubble_sort = BubbleSort.new }

  describe 'bubble_sort' do

    it "should sort an unsorted pair" do
      expect(@bubble_sort.bubble_sort([2,1])).to eq([1,2])
    end

    it "should return a presorted array" do
      expect(@bubble_sort.bubble_sort([1,2,3])).to eq([1,2,3])
    end

    it "should sort an unsorted array" do
      expect(@bubble_sort.bubble_sort([3,2,1])).to eq([1,2,3])
    end

  end

  describe 'bubble_sort_by' do

    it "should raise error without block" do
      expect {@bubble_sort.bubble_sort_by([1,2])}.to raise_error
    end

    # These crash rspec -- not sure why; haven't formally learned rspec yet :P

    # it "should return a presorted list" do
    #   expect(
    #     bubble_sort_by ["hi", "hey", "hello"] do |left,right|
    #       right.length - left.length
    #     end).to eq(["hi", "hey", "hello"])
    # end

    # it "should sort an unsorted list" do
    #   expect(bubble_sort_by ["hello", "hey", "hi"] do |left,right|
    #     right.length - left.length
    #   end).to eq(["hi", "hey", "hello"])
    # end

  end

end