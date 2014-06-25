require_relative 'enumerables'

describe Enumerable do

  # i don't know how to write specs for many of these
  $numbers = [1,2,3,4,5]

  describe "my_all?" do

    it "should return true if all true" do
      expect($numbers.my_all? { |x| x.class == Fixnum }).to eq(true)
    end

    it "should return false if any false" do
      expect($numbers.my_all? { |x| x % 2 == 0 }).to eq(false)
    end
  end

  describe "my_any?" do
    it "should return true if any true" do
      expect([1,2,"foo"].my_any? { |x| x.class == String }).to eq(true)
    end

    it "should return false is none true" do
      expect($numbers.my_any? { |x| x.class == String}).to eq(false)
    end
  end

  describe "my_count" do
    it "should count all elements if not given a block" do
      expect($numbers.my_count).to eq(5)
    end

    it "should only count matching elements if given a block" do
      expect($numbers.my_count { |x| x % 2 == 0 }).to eq(2)
    end
  end

  describe "my_inject" do
    it "should return the product of all nums (given the right block)" do
      expect($numbers.my_inject(1) { |product, num| product *= num }).to eq(120)
    end
  end

  describe "my_map" do

    it "should accept blocks" do
      expect($numbers.my_map { |x| x**3 }).to eq([1,8,27,64,125])
    end

    test_proc = Proc.new { |x| x ** 2 }
    
    it "should accept procs" do
      expect($numbers.my_map(test_proc)).to eq([1,4,9,16,25])
    end

    it "should accept procs and blocks" do
      expect($numbers.my_map(test_proc) { |x| x+3 }).to eq([16,25,36,49,64])
    end

  end

end