joltages = []

File.open('data.txt').each do |line|
  joltages << line.to_i
end

joltages << 0                   # Initial joltage
joltages << joltages.max() + 3  # Final joltage

joltages.sort!()

def count_diffs(joltages)
  diffs = {}

  joltages.each_with_index do |joltage, i|
    next if i == 0

    other_joltage = joltages[i - 1]
    diff = (joltage - other_joltage).abs()

    if diffs[diff]
      diffs[diff] += 1
    else
      diffs[diff] = 1
    end
  end

  diffs
end

def is_chain_valid(diffs)
  diffs.keys.none? { |k| k > 3 }
end

joltage_diffs = count_diffs(joltages)

puts "\n--- Part 1 ---"
puts "There were #{joltage_diffs[1]} 1-volt differences and #{joltage_diffs[3]} 3-volt differences"
puts "Multiplied together they equal #{joltage_diffs[1] * joltage_diffs[3]}"


