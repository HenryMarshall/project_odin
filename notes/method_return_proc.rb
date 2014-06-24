def compose proc1, proc2
  Proc.new do |x|
    proc2.call(proc1.call(x))
  end
end
square = Proc.new { |x| x ** 2 }
double = Proc.new { |x| x * 2  }

double_then_square = compose double, square
square_then_double = compose square, double
puts double_then_square.call(5)
puts square_then_double.call(5)