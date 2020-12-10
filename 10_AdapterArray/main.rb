joltages = []

File.open('data.txt').each do |line|
  joltages << line.to_i
end

puts "There are #{joltages.length} joltages in this file."
