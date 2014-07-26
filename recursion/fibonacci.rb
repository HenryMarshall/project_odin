def fibs n
  x, y = 0, 1
  results = []
  n.times do
    results << x
    x, y = y, x + y
  end
  results
end

def fibs_rec n, x=0, y=1, results=[]
  return results if n <= 0
  results << x
  fibs_rec n-1, y, x + y, results
end