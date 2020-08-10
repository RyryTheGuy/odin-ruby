class LinkedList
  attr_accessor :head, :tail, :size

  def initialize(val = nil)
    @head = Node.new(val)
    @tail = @head
    @size =  val == nil ? nil : 1
  end

  def append(value)
    # Create the linked list if no value was specified on init
    if @size.nil?
      initialize(value)
    else
      # Create the node
      node = Node.new(value)
      # Make the last node's next_node pointer point to the newest node 
      @tail.next_node = node
      # Make the newest node the tail of the linked list 
      @tail = node
      # Increase the size
      @size += 1
    end
  end
  
  def prepend(value)
    # Create the linked list if no value was specified on init
    if @size.nil?
      initialize(value)
    else
      # Create the node
      node = Node.new(value)
      # Make the node's next_node pointer point to the head node (first node) 
      node.next_node = @head
      # Make the new node the current head of the linked list
      @head = node
      # Increase the size
      @size += 1
    end
  end
  
  def at(index)
    # Return an error if the size is nil or the index is larger than or equal to the size
    if @size == nil || @size <= index
      "Error: Index out of range"
    else
      # Get the head node
      node = @head
      # Go to the next node index amount of times
      index.times { node = node.next_node unless node.next_node.nil? }
      # Return the node
      node
    end
  end

  def pop
    case @size
    when nil
      return
    when 1
      # There are no more nodes in the list
      @size = nil
      removed = @head
      @head = nil
      @tail = nil
      # Return the removed node
      return removed
    else
      # Grab the node before the tail
      node = self.at(@size - 2)
      # Decrease the size of the linked list
      @size -= 1
      # Grab the node that's about to be removed
      removed = node.next_node
      # Remove the tail/last node and set the new tail
      node.next_node = nil 
      @tail = node
      # Return the removed node
      return removed
    end
  end

  def contains?(value = nil)
    !self.find(value).nil?
  end
  
  def find(value = nil)
    return nil if value.nil?
  
    # Get the first node and check every node for the value
    node = @head
    for i in 1..@size do
      return i-1 if node.value == value
      node = node.next_node
    end
    # Value isn't in the list
    nil
  end
  
  def to_s
    node = @head
    string = ""
    until node.nil? do
      string += "( #{node.value} ) -> "
      node = node.next_node
    end
    string += "nil"
  end

  def insert_at(value = nil, index)
    # Return nothing if value isn't specified
    return if value == nil

    if index == 0
      # Index == 0 is the same as a prepend
      self.prepend(value)
    elsif (1..@size-1).include?(index)
      # Get the node before the insertion point
      node_before = self.at(index - 1)
      # Create a new node with the given value
      new_node = Node.new(value)
      
      # Make the new node's pointer the node that is in the index spot
      new_node.next_node = node_before.next_node
      # Make the node before the index spot's pointer go to the new node
      node_before.next_node = new_node
      # Increase the size of the linked list
      @size += 1
    end
  end
  
  def remove_at(index)
    if index == @size - 1
      # Index equaling the last node in the array is the same as pop'ing
      self.pop
    elsif (1..@size-1).include?(index)
      # Get the node before the node we want to remove
      node_before = self.at(index - 1)
      # Get the node after the node we want to remove
      node_after = node_before.next_node.next_node

      # Make the node before's pointer point at the node_after
      node_before.next_node = node_after
      # Decrease the linked list size
      @size -= 1
    end
  end 
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

link = LinkedList.new(20)
p link.to_s   # "( 20 ) -> nil"
link.append(10)
p link.to_s   # "( 20 ) -> ( 10 ) -> nil"
link.prepend(30)
p link.to_s   # "( 30 ) -> ( 20 ) -> ( 10 ) -> nil"
link.insert_at(1, 1)
p link.to_s   # "( 30 ) -> ( 1 ) -> ( 20 ) -> ( 10 ) -> nil"
link.remove_at(1)
p link.to_s   # "( 30 ) -> ( 20 ) -> ( 10 ) -> nil"