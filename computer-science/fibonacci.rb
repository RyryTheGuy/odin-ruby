def fibs(counter)
  if counter == 0
    return []
  elsif counter == 1
    return [1]
  else 
    arr = [1, 1]
    counter -= 2
    counter.times { |i| arr << arr[i] + arr[i + 1]}
    return arr
  end
end

def fibs_rec(n)
  return [n] if n < 2
  return [1, 1] if n == 2

  fibs_rec(n - 1) << fibs_rec(n - 1)[-1] + fibs_rec(n - 1)[-2]
end

x = 20
p fibs(x)
p fibs_rec(x)