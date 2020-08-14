class Node
  include Comparable
  attr_accessor :value, :left_node, :right_node

  def <=>(other_node)
    @value <=> other_node.value
  end

  def initialize(value = nil)
    @value = value
    @left_node = nil
    @right_node = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(arr)
    @arr = arr
    @root = nil
  end

  def build_tree
    # Sort and remove duplicates
    arr = @arr.sort.uniq

    # Make the BST
    @root = Node.new(arr[arr.size/2])
    @root.left_node = create_node(arr[0..(arr.size/2 - 1)])
    @root.right_node = create_node(arr[(arr.size/2 + 1)..arr.size - 1])

    return @root
  end
  
  def insert(value, root = @root)
    # Insert new node / Base Case
    return Node.new(value) if root.nil? || root.value == value

    if value < root.value
      root.left_node = insert(value, root.left_node)
    else
      root.right_node = insert(value, root.right_node)
    end

    return root
  end

  def delete(value, root = @root)
    # Base case
    return root if root.nil?

    # Search the binary tree for the value
    if value < root.value
      root.left_node = delete(value, root.left_node)
    elsif value > root.value
      root.right_node = delete(value, root.right_node)
    else
      # Found the value to be deleted
      # See if the node has children
      if root.left_node.nil?
        temp = root.right_node
        root = nil
        return temp
      elsif root.right_node.nil?
        temp = root.left_node
        root = nil
        return temp
      end

      # Node has 2 children
      # Grab the root's inorder successor
      temp = smallest_node(root.right_node)
      
      # Copy the inorder successor's data to the root
      root.value = temp.value

      # Delete the inorder successor
      root.right_node = delete(temp.value, root.right_node)
    end

    return root
  end

  def find(value, root = @root)
    # Base cases
    return root if root.nil? || root.value == value

    if value < root.value
      find(value, root.left_node)
    else
      find(value, root.right_node)
    end
  end

  def level_order(root = @root)
    # Base case
    return if root.nil?

    queue = []
    arr = []
    queue.unshift(root)

    # Loop until the queue is empty
    until queue.size == 0
      # Grab the first node in the queue
      current = queue[-1] 

      # Remove the first node in the queue
      arr << queue.pop.value

      # Add the current node's left and right child to the queue 
      queue.unshift(current.left_node) unless current.left_node.nil?
      queue.unshift(current.right_node) unless current.right_node.nil?
    end

    return arr
  end

  def inorder(root = @root, arr = [])
    # Base Case
    return if root.nil?

    arr << inorder(root.left_node)
    arr << root.value
    arr << inorder(root.right_node)

    # Returns the array of numbers without the extra arrays and nil values
    return arr.flatten.compact
  end
  
  def preorder(root = @root, arr = [])
    # Base Case
    return if root.nil?
  
    arr << root.value
    arr << preorder(root.left_node)
    arr << preorder(root.right_node)
  
    # Returns the array of numbers without the extra arrays and nil values
    return arr.flatten.compact

  end
  
  def postorder(root = @root, arr = [])
    # Base Case
    return if root.nil?
  
    arr << postorder(root.left_node)
    arr << postorder(root.right_node)
    arr << root.value
  
    # Returns the array of numbers without the extra arrays and nil values
    return arr.flatten.compact

  end

  def height(root = @root)
    return -1 if root.nil?

    height_left = height(root.left_node)
    height_right = height(root.right_node)
      
    return  height_left > height_right ? height_left + 1 : height_right + 1
  end

  def pretty_print(node = @root, prefix="", is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right_node
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value.to_s}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left_node
  end

  private
  def create_node(arr)
    return nil if arr.size < 1
    # Return the node if it is a "leaf" or node without a left and right
    return Node.new(arr[0]) if arr.size == 1

    # Create a node from the middle of the array
    node = Node.new(arr[arr.size/2])

    # Create the left node and assign it to the node's left side
    node.left_node = create_node(arr[0..(arr.size/2 - 1)])

    # Create the right node and assign it to the node's right side
    node.right_node = create_node(arr[(arr.size/2 + 1)..arr.size - 1])

    return node
  end

  def smallest_node(node)
    current = node

    current = current.left_node until current.left_node.nil?

    return current
  end

end

# node1 = Node.new(100)
# node2 = Node.new(10)
# p node1 > node2

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.build_tree
tree.insert(6)
# tree.pretty_print
tree.pretty_print
# p tree.find(1)
# p tree.inorder
# p tree.preorder
# p tree.postorder
p tree.height
