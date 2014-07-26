# require 'pry_debug'

def factorial n, product=1
  return product if n == 1
  product = factorial n-1, product * n
end

def factorial_solution n
  return 1 if n == 0
  n * factorial(n-1)
end

def palindrome? characters
  return true if characters.length <= 1
  characters.shift == characters.pop ? palindrome?(characters) : (return false)
end

def pirates n
  if n < 1
    puts "no more beer"
  else
    puts "#{n} bottles of beer on the wall"
    pirates n-1
  end
end

def fib position, x=0, y=1
  return x if position == 0
  fib position -1, y, x + y
end

def flattener arr, result=[]
  arr.each do |element|
    if element.kind_of? Array
      element.flatten 1
      flattener element, result
    else
      result << element
    end
  end
  result
end

def roman_mapper number, result=""
  return result if number == 0
  digits = number.to_s.chars.map(&:to_i)
  magnitude = digits.length

  case magnitude
  when 1
    one   = "I"
    five  = "V"
    ten   = "X"
  when 2
    one   = "X"
    five  = "L"
    ten   = "C"
  when 3
    one   = "C"
    five  = "D"
    ten   = "M"
  when 4
    one   = "M"
    five  = "=V="
    ten   = "=X="
  end

  digit = digits.shift
  number = digits.join.to_i
  case digit
  when 0      then conversion = ""
  when 1..3   then conversion = one * digit
  when 4      then conversion = "#{one}#{five}"
  when 5      then conversion = five
  when 6..8   then conversion = "#{five}#{one * (digit % 5)}"
  when 9      then conversion = "#{one}#{ten}"
  end

  roman_mapper number, result + conversion
end



def integer_to_roman number, result = ""
  roman_mapping = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod divisor
    result << roman_mapping[divisor] * quotient
    return integer_to_roman(modulus, result) if quotient > 0
  end
end

def roman_to_integer roman_numeral, result = 0
  arabic_mapping = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
  }

  return result if roman_numeral.empty?

  arabic_mapping.keys.each do |key|
    # check out #start_with?
    if key.length == 1
      if roman_numeral[0] == key
        result += arabic_mapping[key]
        return roman_to_integer roman_numeral[1..-1], result
      end
    elsif key.length == 2
      if roman_numeral[0..1] == key
        result += arabic_mapping[key]
        return roman_to_integer roman_numeral[2..-1], result
      end 
    end
  end
end