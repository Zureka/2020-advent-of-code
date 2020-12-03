require_relative "helpers"
require "pry"

tree_rows = []

File.open("data.txt").each do |line|
  tree_rows << line.strip.split("")
end

puts "\n--- Part 1 ---"
tree_count = count_num_trees(tree_rows, 3, 1)
puts "Encountered #{tree_count} trees along the \"right 3 down 1\" path"

puts "\n--- Part 2 ---"
r1_d1_count = count_num_trees(tree_rows, 1, 1)
r3_d1_count = count_num_trees(tree_rows, 3, 1)
r5_d1_count = count_num_trees(tree_rows, 5, 1)
r7_d1_count = count_num_trees(tree_rows, 7, 1)
r1_d2_count = count_num_trees(tree_rows, 1, 2)

puts "Right 1, Down 1: Encountered #{r1_d1_count} trees."
puts "Right 3, Down 1: Encountered #{r3_d1_count} trees."
puts "Right 5, Down 1: Encountered #{r5_d1_count} trees."
puts "Right 7, Down 1: Encountered #{r7_d1_count} trees."
puts "Right 1, Down 2: Encountered #{r1_d2_count} trees."
puts "All trees encountered multiplied together: #{r1_d1_count * r3_d1_count * r5_d1_count * r7_d1_count * r1_d2_count}"
