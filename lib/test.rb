def hash_func(user, pass)
  hashAddress = 5381
  i = 0
  string = user + pass
  while i < string.length
    hashAddress = ((hashAddress << 5) + hashAddress) + string[i].ord
    i += 1
  end
  return hashAddress
end

p hash_func("guy", "password")
