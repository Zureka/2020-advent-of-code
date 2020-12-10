nums = []

File.open('data.txt').each do |line|
  nums << line.to_i
end

pos = 25
corruption_found = false

def get_preamble(nums, pos, size)
  return nums[pos-size..pos-1]
end

while pos < nums.length && !corruption_found
  preamble = get_preamble(nums, pos, 25)
  test_num = nums[pos]

  tests = preamble.permutation(2).to_a
  is_valid = tests.map { |t| t.sum() }.any? { |result| result == test_num }

  if is_valid
    pos += 1
  else
    corruption_found = true
  end
end

if corruption_found
  corrupt_value = nums[pos]

  puts "\n--- Part 1 ---"
  puts "Found the corruption: #{corrupt_value}"
  
  weakness_found = false

  (2..).each do |size|
    new_pos = size

    while new_pos < nums.length && !weakness_found
      preamble = get_preamble(nums, new_pos, size)
      test_num = nums[new_pos]
      weakness_found = preamble.sum  == corrupt_value 
      new_pos += 1 unless weakness_found
    end

    if weakness_found
      corrupt_preamble = get_preamble(nums, new_pos, size)
      puts "\n--- Part 2 ---"
      puts "The encryption weakness is #{corrupt_preamble.min() + corrupt_preamble.max()}"
      break
    end
  end
end

