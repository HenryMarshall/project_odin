module Enumerable
  def my_each
    elems_number = self.length
    i = 0
    while i < elems_number
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    elems_number = self.length
    i = 0
    while i < elems_nubmer
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select
    results = []
    self.my_each { |x| results << x if yield x }
    results
  end

  def my_all?
    self.my_each { |x| return false unless yield x }
    true
  end

  def my_any?
    self.my_each { |x| return true if yield x }
    false
  end

  def my_none?
    !self.my_any?
  end

  def my_inject accumulator=0
    accumulator = accumulator
    self.my_each do |x|
      accumulator = yield accumulator, x
    end
    accumulator
  end

  # multiply_els is in specs

  def my_count
    self.my_inject do |total, elem|
      # without a block count everything
      if !block_given? or yield(elem)
        total += 1 
      end
      total
    end
  end

  def my_map(proc=nil)
    results = []
    if block_given? && proc
      self.each { |x| results << proc.call(yield x) }
    elsif proc
      self.each { |x| results << proc.call(x) }
    elsif block_given?
      self.each { |x| results << yield(x) }
    else
      results = self
    end
    results
  end

end


my_proc = Proc.new { |x| x ** 2 }
puts "proc: #{[1,2,3,4,5,6].my_map my_proc}"
puts "block: #{[1,2,3,4,5,6].my_map { |x| x**3 }}"
puts "procblock: #{[1,2,3,4,5,6].my_map(my_proc) { |x| x+3 }}"