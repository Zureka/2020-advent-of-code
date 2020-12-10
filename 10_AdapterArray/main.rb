joltages = []

File.open('data.txt').each do |line|
  joltages << line.to_i
end

joltages << 0                   # Initial joltage
joltages << joltages.max() + 3  # Final joltage

joltages.sort!()

def count_diffs(joltages)
  joltage_diffs = {}

  joltages.each_with_index do |joltage, i|
    next if i == 0

    other_joltage = joltages[i - 1]
    diff = (joltage - other_joltage).abs()

    if joltage_diffs[diff]
      joltage_diffs[diff] += 1
    else
      joltage_diffs[diff] = 1
    end
  end

  joltage_diffs
end

def is_chain_valid(joltage_diffs)
  joltage_diffs.keys.none? { |k| k > 3 }
end

diffs = count_diffs(joltages)

puts "\n--- Part 1 ---"
puts "There were #{diffs[1]} 1-volt differences and #{diffs[3]} 3-volt differences"
puts "Multiplied together they equal #{diffs[1] * diffs[3]}"


