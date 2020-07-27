# Bubble Sort Mini-Project

def bubble_sort(arr)
  # Grab the length of the array
  n = arr.length
  # Keep looping til the numbers don't need to be swapped anymore
  until n <= 1
    # Replaces 'n' at the end of the loop so if new_n doesn't get changed the loop will end
    new_n = 0
    # Loop through the array
    for i in 1..(n-1) do
      # Number on the left needs to be bigger than the number on the right
      if arr[i - 1] > arr[i]
        # Swap the numbers
        temp = arr[i]
        arr[i] = arr[i - 1]
        arr [i - 1] = temp
        # Keep the loop going
        new_n = i
      end
    end
    n = new_n
  end
  # Return the array
  arr
end

p bubble_sort([4,3,78,2,0,2])