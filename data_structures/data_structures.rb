class Node
  # attr_accessor value, children

  def initialize value, children
    @value = value
    @children = children
  end
end

def build_tree data, value=data.first, parent=value
  return nil if value.nil?

  # left_index  = data.find_index { |x| x <= value }
  # right_index = data.find_index { |x| x >  value }

  left_index   = data.find_index { |x| x <= value and x <= parent }
  right_index  = data.find_index { |x| x >= value and x >= parent }

  left_value  = left_index.nil?  ? nil : data.delete_at(left_index)
  right_value = right_index.nil? ? nil : data.delete_at(right_index)

  left  = build_tree data, left_value, value
  right = build_tree data, right_value, value

  Node.new value, [left, right]

end