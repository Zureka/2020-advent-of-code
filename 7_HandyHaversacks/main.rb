require_relative "bag_parser"
require "set"

bag_rules = []

File.open("data.txt").each do |line|
  bag_rules << BagParser.parse_bag_rule(line)
end

puts "\n--- Part 1 ---"

# Use a set to remove any duplicate colors
can_hold_gold = Set.new

# Find initial bag colors that hold a "shiny gold" bag directly
bag_rules.each do |rule|
  if rule[:contain_colors].any? { |info| info[:color] == "shiny gold" }
    can_hold_gold << rule[:bag_color]
  end
end

# Arbitrary amount of times to iterate until all bag colors are found.
10.times do
  can_also_hold_gold = []

  # Determine if there are other bag colors that could hold a shiny gold bag
  can_hold_gold.each do |color|
    bag_rules.each do |rule|
      if rule[:contain_colors].any? { |info| info[:color] == color }
        can_also_hold_gold << rule[:bag_color]
      end
    end
  end

  # Add newly found bag colors to the set
  can_also_hold_gold.each do |color|
    can_hold_gold.add(color)
  end
end

puts "Based on the baggage rules, there are #{can_hold_gold.length} bag colors that could hold a \"shiny gold\" bag."

puts "\n--- Part 2 ---"

held_in_gold = []
shiny_gold_bag_rule = bag_rules.select { |rule| rule[:bag_color] == "shiny gold" }[0]

shiny_gold_bag_rule[:contain_colors].each do |info|
  info[:num].times do
    held_in_gold << {color: info[:color], processed: false}
  end
end

while held_in_gold.any? { |info| info[:processed] == false }
  also_held_in_gold = []

  held_in_gold.each_with_index do |color_info, index|
    if color_info[:processed] == false
      bag_rule = bag_rules.select { |rule| rule[:bag_color] == color_info[:color] }[0]

      bag_rule[:contain_colors].each do |info|
        info[:num].times do
          also_held_in_gold << {color: info[:color], processed: false}
        end
      end

      color_info[:processed] = true
    end
  end

  also_held_in_gold.each do |color|
    held_in_gold << color
  end
end

puts "Based on the baggage rules, one would need to purchase #{held_in_gold.length} bags to fit inside the \"shiny gold\" bag."
