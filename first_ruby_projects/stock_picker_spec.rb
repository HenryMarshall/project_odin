require_relative 'stock_picker'

describe "stock_picker" do
  it "should recognize when min is before max" do
    expect(stock_picker([1,2,3])).to eq([0,2])
  end

  it "should recognize when min is after max" do
    expect(stock_picker([3,1,2])).to eq([1,2])
  end

  it "should recognize when there are no good options" do
    expect(stock_picker([3,2,1])).to eq("do_not_buy")
  end

end