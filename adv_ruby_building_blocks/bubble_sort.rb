class BubbleSort
  def bubble_sort unsorted
    self.bubble_sort_by(unsorted) { |left,right| right - left}
  end

  def bubble_sort_by unsorted
    unsorted_length = unsorted.length
    (unsorted_length-1).times do |outer|
      (unsorted_length-outer-1).times do |inner|
        if yield(unsorted[inner], unsorted[inner+1]) < 0
          unsorted[inner], unsorted[inner+1] = unsorted[inner+1], unsorted[inner]
        end
      end
    end
    sorted = unsorted
  end

end

# sorter = BubbleSort.new
# sorter.bubble_sort [2,6,3,1,8,44,1]
# unsorted = %w(a abc ab abcde a)
# sorter.bubble_sort_by(unsorted) { |left,right| right.length - left.length }