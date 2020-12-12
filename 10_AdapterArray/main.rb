require_relative "helpers"

adapters = []

File.open('data.txt').each do |line|
  adapters << line.to_i
end

adapters << 0                   # Initial joltage
adapters << adapters.max() + 3  # Final joltage

adapters.sort!()

def count_diffs(joltages)
  diffs = {}

  adapters.each_with_index do |joltage, i|
    next if i == 0

    other_joltage = adapters[i - 1]
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

joltage_diffs = count_diffs(adapters)

puts "\n--- Part 1 ---"
puts "There were #{joltage_diffs[1]} 1-volt differences and #{joltage_diffs[3]} 3-volt differences"
puts "Multiplied together they equal #{joltage_diffs[1] * joltage_diffs[3]}"


puts "\n--- Part 2 ---"

helper = JoltageHelpers.new(adapters)
possible_path_count = helper.count_adapter_paths()

puts "There are #{possible_path_count} possible paths with the given adapters"


