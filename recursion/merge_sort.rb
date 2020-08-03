def merge_sort(arr)
  length = arr.length

  if length < 2
    return arr
  else
    left = merge_sort(arr[0, length/2])
    right = merge_sort(arr[length/2, length])
    return merge(left, right)
  end
end

def merge(left, right)
  result = []
  while left.count > 0 && right.count > 0
    if left.first <= right.first
      result << left.first
      left.shift
    else
      result << right.first
      right.shift
    end
  end
  
  while left.count > 0
    result << left.first
    left.shift
  end
  while right.count > 0
    result << right.first
    right.shift
  end

  return result
end

p merge_sort([4,3,6,2,1,7,5])