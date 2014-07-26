require 'pry'

def merge_sort array
  array_length = array.length
  if array_length == 1
    array
  elsif array_length > 1
    first_half = merge_sort array[0..(array_length/2-1)]
    second_half = merge_sort array[(array_length/2)..-1]
    merge first_half, second_half
  end
end

def merge array1, array2
  result = []
  until array1.empty? or array2.empty?
    if array1[0] <= array2[0]
      result << array1.shift 
    else
      result << array2.shift
    end
  end

  # once an array is empty, append the other
  if array1.empty?
    result += array2
  else
    result += array1
  end
end